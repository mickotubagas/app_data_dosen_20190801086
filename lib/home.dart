import 'package:app_data_dosen_20190801086/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nidnController = TextEditingController();
  final TextEditingController _bidkelController = TextEditingController();
  final TextEditingController _jabatanController = TextEditingController();
  final CollectionReference _dosens =
      FirebaseFirestore.instance.collection('dosens');

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nidnController,
                  decoration: const InputDecoration(labelText: 'NIDN'),
                ),
                TextField(
                  controller: _namaController,
                  decoration: const InputDecoration(labelText: 'Nama'),
                ),
                TextField(
                  controller: _bidkelController,
                  decoration:
                      const InputDecoration(labelText: 'Bidang Keahlian'),
                ),
                TextField(
                  controller: _jabatanController,
                  decoration: const InputDecoration(labelText: 'Jabatan'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final String nidn = _nidnController.text;
                    final String nama = _namaController.text;
                    final String bidkel = _bidkelController.text;
                    final String jabatan = _jabatanController.text;

                    if (nidn != null) {
                      await _dosens.add({
                        "nidn": nidn,
                        "nama": nama,
                        "bidkel": bidkel,
                        "jabatan": jabatan,
                      });

                      _nidnController.text = '';
                      _namaController.text = '';
                      _bidkelController.text = '';
                      _jabatanController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String dosensId) async {
    await _dosens.doc(dosensId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data Dosen Berhasil Dihapus')));
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nidnController.text = documentSnapshot['nidn'];
      _namaController.text = documentSnapshot['nama'];
      _bidkelController.text = documentSnapshot['bidkel'];
      _jabatanController.text = documentSnapshot['jabatan'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nidnController,
                  decoration: const InputDecoration(labelText: 'NIDN'),
                ),
                TextField(
                  controller: _namaController,
                  decoration: const InputDecoration(labelText: 'Nama'),
                ),
                TextField(
                  controller: _bidkelController,
                  decoration:
                      const InputDecoration(labelText: 'Bidang Keahlian'),
                ),
                TextField(
                  controller: _jabatanController,
                  decoration: const InputDecoration(labelText: 'Jabatan'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String nidn = _nidnController.text;
                    final String nama = _namaController.text;
                    final String bidkel = _bidkelController.text;
                    final String jabatan = _jabatanController.text;
                    await _dosens.doc(documentSnapshot!.id).update({
                      "nidn": nidn,
                      "nama": nama,
                      "bidkel": bidkel,
                      "jabatan": jabatan,
                    });
                    _nidnController.text = documentSnapshot['nidn'];
                    _namaController.text = documentSnapshot['nama'];
                    _bidkelController.text = documentSnapshot['bidkel'];
                    _jabatanController.text = documentSnapshot['jabatan'];
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const MainDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Column(
          children: <Widget>[
            const Text(
              "Dashboard",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30,
                fontFamily: 'jaapokkienchance',
              ),
            ),
            const Text(
              "App Data Dosen",
              style: TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 30,
                fontFamily: 'jaapokkienchance',
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "List Dosen :",
              style: TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 20,
                fontFamily: 'jaapokkienchance',
              ),
            ),
            SizedBox(
              height: 300,
              child: StreamBuilder(
                stream: _dosens.snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return ListView.builder(
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            title: Center(
                              child: Text(
                                documentSnapshot['nama'],
                                style: const TextStyle(
                                    fontFamily: 'jaapokkienchance'),
                              ),
                            ),
                            subtitle: Column(
                              children: [
                                Text(
                                  documentSnapshot['nidn'],
                                  style: const TextStyle(
                                      fontFamily: 'jaapokkienchance'),
                                ),
                                Text(
                                  documentSnapshot['jabatan'],
                                  style: const TextStyle(
                                      fontFamily: 'jaapokkienchance'),
                                ),
                                Text(
                                  documentSnapshot['bidkel'],
                                  style: const TextStyle(
                                      fontFamily: 'jaapokkienchance'),
                                ),
                              ],
                            ),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () =>
                                          _update(documentSnapshot)),
                                  IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () =>
                                          _delete(documentSnapshot.id)),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
