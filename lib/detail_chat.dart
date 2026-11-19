import 'package:flutter/material.dart';

//membuat model pesan, blueprint
class Message {
  final String chat;
  final bool isMe;

  Message({required this.chat, required this.isMe});
}

class DetailChat extends StatefulWidget {
  const DetailChat({super.key});

  @override
  State<DetailChat> createState() => _DetailChatState();
}

class _DetailChatState extends State<DetailChat> {
  //
  TextEditingController textPesan = TextEditingController();
  final List<Message> pesan = [
    Message(chat: "Hai bro", isMe: false),
    Message(chat: "Hello bro", isMe: true),
    Message(chat: "lu lagi ngapain bro?", isMe: false),
    Message(chat: "Gw lagi belajar flutter nih", isMe: true),
  ];

  //membuat fungsi tombol kirim
  void kirimPesan() {
    if (textPesan.text.trim().isEmpty) return;
    setState(() {
      pesan.add(Message(chat: textPesan.text, isMe: true));
    });

    textPesan.clear(); //bersihkan input chat nya

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          pesan.add(Message(chat: "oke bro", isMe: false));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: CircleAvatar(child: Icon(Icons.person)),
            ),
            Text("ridho"),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              debugPrint("Video Call!");
            },
            icon: Icon(Icons.videocam),
          ),
          IconButton(
            onPressed: () {
              debugPrint("Telepon");
            },
            icon: Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {
              debugPrint("Menu Lain");
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: pesan.length,
              itemBuilder: (context, index) {
                final psn = pesan[index];
                return Align(
                  alignment:
                      psn.isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: psn.isMe ? Colors.green[50] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(psn.chat),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller:
                        textPesan, // <-- 1. Sambungkan controller di sini
                    onSubmitted: (value) {
                      kirimPesan(); // <-- 2. Supaya di web bisa langsung kirim saat tekan tombol Enter
                    },
                    decoration: InputDecoration(
                      hintText: "Tulis Pesan...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(onPressed: kirimPesan, icon: Icon(Icons.send)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
