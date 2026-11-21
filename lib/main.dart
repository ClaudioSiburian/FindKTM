import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/config/supabase_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SupabaseConfig.url,
    publishableKey: SupabaseConfig.publishableKey,
  );
  runApp(const FindKtmApp());
}

class FindKtmApp extends StatelessWidget {
  const FindKtmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FindKTM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E3192)),
      ),
      home: const CekKoneksiScreen(),
    );
  }
}

// sementara, buat ngetes koneksi ke supabase
class CekKoneksiScreen extends StatefulWidget {
  const CekKoneksiScreen({super.key});

  @override
  State<CekKoneksiScreen> createState() => _CekKoneksiScreenState();
}

class _CekKoneksiScreenState extends State<CekKoneksiScreen> {
  late Future<Map<String, int>> _hasil = _cek();

  Future<Map<String, int>> _cek() async {
    final db = Supabase.instance.client;
    final departemen = await db.from(SupabaseConfig.tDepartemen).select();
    final langkah = await db.from(SupabaseConfig.tLangkahPanduan).select();
    return {
      'departemen': departemen.length,
      'langkah_panduan': langkah.length,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FindKTM — Cek Koneksi Supabase')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: FutureBuilder<Map<String, int>>(
            future: _hasil,
            builder: (context, snap) {
              if (snap.connectionState != ConnectionState.done) {
                return const CircularProgressIndicator();
              }
              if (snap.hasError) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.cloud_off, size: 56, color: Colors.red),
                    const SizedBox(height: 12),
                    Text('Gagal terhubung:\n${snap.error}',
                        textAlign: TextAlign.center),
                    TextButton(
                      onPressed: () => setState(() => _hasil = _cek()),
                      child: const Text('Coba lagi'),
                    ),
                  ],
                );
              }
              final data = snap.data!;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.cloud_done, size: 56, color: Colors.green),
                  const SizedBox(height: 12),
                  const Text('Terhubung ke Supabase',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Departemen: ${data['departemen']} data'),
                  Text('Langkah panduan: ${data['langkah_panduan']} data'),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
