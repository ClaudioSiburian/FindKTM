import 'package:flutter_findktm/core/config/supabase_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('konfigurasi Supabase terisi', () {
    expect(SupabaseConfig.url, startsWith('https://'));
    expect(SupabaseConfig.url, endsWith('.supabase.co'));
    expect(SupabaseConfig.publishableKey, startsWith('sb_publishable_'));
  });
}
