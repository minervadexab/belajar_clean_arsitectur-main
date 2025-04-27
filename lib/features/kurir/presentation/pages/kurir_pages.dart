import 'package:belajar_clean_arsitectur/core/components/custom-drawer.dart';
import 'package:belajar_clean_arsitectur/features/gudang/presentation/bloc/gudang_bloc.dart';
import 'package:belajar_clean_arsitectur/features/kurir/data/models/kurir_model.dart';
import 'package:belajar_clean_arsitectur/features/kurir/presentation/bloc/kurir_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class KurirPages extends StatelessWidget {
  const KurirPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kurir Pages'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  TextEditingController namaKurirController =
                      TextEditingController();
                  TextEditingController nomorTlpKurirController =
                      TextEditingController();
                  TextEditingController emailController =
                      TextEditingController();
                  TextEditingController layananController =
                      TextEditingController();
                  String? selectedValueGudangId;
                  // Form Key untuk validasi
                  final formKey = GlobalKey<FormState>();

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Input Nama Kurir
                          TextFormField(
                            controller: namaKurirController,
                            decoration: const InputDecoration(
                              labelText: 'Nama Kurir',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nama Kurir tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Input nomorTlp Kurir
                          TextFormField(
                            controller: nomorTlpKurirController,
                            decoration: const InputDecoration(
                              labelText: ' Nomor Telephone',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter
                                  .digitsOnly, // hanya angka
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'nomorTlp Kurir tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Input email
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              labelText: ' Email',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Input layanan
                          TextFormField(
                            controller: layananController,
                            decoration: const InputDecoration(
                              labelText: 'Layanan',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // dropdown gudang
                          BlocBuilder<GudangBloc, GudangState>(
                            bloc: context.read<GudangBloc>()
                              ..add(GudangEventGetAll()),
                            builder: (context, state) {
                              if (state is GudangStateError) {
                                return Text(state.message);
                              }
                              if (state is GudangStateLoadedAll) {
                                final gudang = state.gudangs;
                                return DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Gudang',
                                    border: OutlineInputBorder(),
                                  ),
                                  value: selectedValueGudangId,
                                  items: gudang
                                      .map(
                                        (e) => DropdownMenuItem(
                                            value: e.id,
                                            child: Text(e.namaGudang)),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    selectedValueGudangId = value;
                                  },
                                  // validasi
                                  validator: (value) => value == null
                                      ? 'Gudang wajib dipilih'
                                      : null,
                                );
                              }
                              // Saat loading
                              return const CircularProgressIndicator();
                            },
                          ),
                          const SizedBox(height: 20),

                          // Tombol Simpan dengan validasi
                          BlocConsumer<KurirBloc, KurirState>(
                            listener: (context, state) {
                              if (state is KurirStateError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.message)));
                              }
                              if (state is KurirStateSuccess) {
                                context.pop();
                                context
                                    .read<KurirBloc>()
                                    .add(KurirEventGetAll());
                              }
                            },
                            builder: (context, state) {
                              return ElevatedButton.icon(
                                onPressed: () {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    // Kirim event add jika form valid
                                    context.read<KurirBloc>().add(
                                          KurirEventAdd(
                                            kurirModel: KurirModel(
                                              id: '',
                                              gudangId: selectedValueGudangId,
                                              namaKurir:
                                                  namaKurirController.text,
                                              nomorTlp:
                                                  nomorTlpKurirController.text,
                                              email: emailController.text,
                                              layanan: layananController.text,
                                            ),
                                          ),
                                        );
                                  }
                                },
                                icon: state is KurirStateLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white)
                                    : const Icon(Icons.save),
                                label: const Text('Simpan Kurir'),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: BlocBuilder<KurirBloc, KurirState>(
        bloc: context.read<KurirBloc>()..add(KurirEventGetAll()),
        builder: (context, state) {
          return BlocListener<KurirBloc, KurirState>(
            listener: (context, state) {
              if (state is KurirStateSuccess) {
                context.read<KurirBloc>().add(KurirEventGetAll());
              }

              if (state is KurirStateError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: state is KurirStateLoading
                ? const Center(child: CircularProgressIndicator())
                : state is KurirStateLoadedAll
                    ? ListView.builder(
                        itemCount: state.kurirs.length,
                        itemBuilder: (context, index) {
                          var kurir = state.kurirs[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            elevation: 4,
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              title: Text(kurir.namaKurir,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text('Layanan: ${kurir.layanan}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          final namaController =
                                              TextEditingController(
                                                  text: kurir.namaKurir);
                                          final nomorTlpController =
                                              TextEditingController(
                                                  text: kurir.nomorTlp);
                                          final emailController =
                                              TextEditingController(
                                                  text: kurir.email);
                                          final layananController =
                                              TextEditingController(
                                                  text: kurir.layanan);
                                          String? selectedValueGudangId =
                                              kurir.gudangId;
                                          context
                                              .read<GudangBloc>()
                                              .add(GudangEventGetAll());
                                          return Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                // edit nama kurir
                                                TextFormField(
                                                  controller: namaController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Nama Kurir',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                const SizedBox(height: 16),

                                                // edit nomor tlp
                                                TextFormField(
                                                  controller:
                                                      nomorTlpController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText:
                                                        'Nomor telephone',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly, // hanya angka
                                                  ],
                                                ),
                                                const SizedBox(height: 20),

                                                // edit email
                                                TextFormField(
                                                  controller: emailController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Email',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                const SizedBox(height: 20),

                                                // edit layanan
                                                TextFormField(
                                                  controller: layananController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Layanan',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                const SizedBox(height: 20),

                                                // edit dropdown gudang
                                                BlocBuilder<GudangBloc,
                                                    GudangState>(
                                                  builder: (context, state) {
                                                    if (state
                                                        is GudangStateError) {
                                                      return Text(
                                                          state.message);
                                                    }

                                                    if (state
                                                        is GudangStateLoadedAll) {
                                                      final gudang =
                                                          state.gudangs;

                                                      return DropdownButtonFormField<
                                                          String>(
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText: 'Gudang',
                                                          border:
                                                              OutlineInputBorder(),
                                                        ),
                                                        value:
                                                            selectedValueGudangId, // nilai awal diisi untuk edit
                                                        items: gudang.map((e) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: e.id,
                                                            child: Text(
                                                                e.namaGudang),
                                                          );
                                                        }).toList(),
                                                        onChanged: (value) {
                                                          selectedValueGudangId =
                                                              value;
                                                        },
                                                        validator: (value) =>
                                                            value == null
                                                                ? 'Gudang wajib dipilih'
                                                                : null,
                                                      );
                                                    }

                                                    return const CircularProgressIndicator();
                                                  },
                                                ),
                                                const SizedBox(height: 20),

                                                ElevatedButton.icon(
                                                  onPressed: () {
                                                    context
                                                        .read<KurirBloc>()
                                                        .add(
                                                          KurirEventEdit(
                                                            kurirModel:
                                                                KurirModel(
                                                              id: kurir.id,
                                                              gudangId:
                                                                  selectedValueGudangId,
                                                              namaKurir:
                                                                  namaController
                                                                      .text,
                                                              nomorTlp:
                                                                  nomorTlpController
                                                                      .text,
                                                              email:
                                                                  emailController
                                                                      .text,
                                                              layanan:
                                                                  layananController
                                                                      .text,
                                                            ),
                                                          ),
                                                        );
                                                    Navigator.pop(context);
                                                  },
                                                  icon:
                                                      const Icon(Icons.update),
                                                  label: const Text(
                                                      'Update Kurir'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('Konfirmasi'),
                                          content: const Text(
                                              'Yakin ingin menghapus kurir ini?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(), // Tutup dialog
                                              child: const Text('Tidak'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                context.read<KurirBloc>().add(
                                                      KurirEventDelete(
                                                          id: kurir.id),
                                                    );
                                                Navigator.of(context)
                                                    .pop(); // Tutup dialog setelah hapus
                                              },
                                              child: const Text('Ya'),
                                            ),
                                          ],
                                        ),
                                      );
                                      // context
                                      //     .read<KurirBloc>()
                                      //     .add(KurirEventDelete(id: kurir.id));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(child: Text('Tidak ada data')),
          );
        },
      ),
    );
  }
}
