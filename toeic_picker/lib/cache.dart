import 'dart:io';

import 'package:redis/redis.dart';

class Cache {
  RedisConnection conn = new RedisConnection();
  int score = 0;
  final String TEST = "TEST";
  final String RESULT = "RESULT";

  void init() {
    if (conn == null) {
      conn = new RedisConnection();
    }
  }

  void send(Object obj) {
    conn
        .connect("192.168.1.3", 6378)
        .then((cmd) => {cmd.send_object(obj).then((resp) => {})})
        .onError((error, stackTrace) => {throw error ?? error});
  }

  void save(String hName, int key, String value) {
    send(["HSET", hName, key, value]);
  }
}