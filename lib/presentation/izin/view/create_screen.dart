import 'package:flutter/material.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard"), actions: const []),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextFormField(
              onTap: () {},
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Tanggal Mulai",
                hintText: "Pilih tanggal",
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Tanggal Selesai",
                hintText: "Pilih tanggal",
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: "Jenis Izin",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: "sakit", child: Text("Sakit")),
                DropdownMenuItem(value: "cuti", child: Text("Cuti")),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Alasan",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {},
                child: const Text("Simpan"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
