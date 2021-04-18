import 'package:redis/redis.dart';

class CacheResult {
  RedisConnection conn = new RedisConnection();
  int score = 0;

  void init() {
    if (conn == null) {
      conn = new RedisConnection();
    }
  }

  void compare(String hName1, String hName2) {
    // TEST
    List<String> res = [];
    conn.connect("192.168.1.3", 6378).then((cmd) => {
          cmd.send_object(["HGETALL", hName1]).then((resp) => {
                res = new List<String>.from(resp),
              })
        });
    // RESULT
    List<String> result = [];
    conn.connect("192.168.1.3", 6378).then((cmd) => {
          cmd.send_object(["HGETALL", hName2]).then((resp) => {
                result = new List<String>.from(resp),
              })
        });
    Future.delayed(
        Duration(milliseconds: 1000),
        () => {
              print("TEST: $res \n"),
              print("RESULT: $result \n"),
              compareList(res, result)
            });
  }

  void compareList(List<String> x, y) {
    var mx = new Map();
    var my = new Map();

    for (var i = 0; i < x.length; i += 2) {
      mx[x[i]] = x[i + 1];
    }
    for (var i = 0; i < y.length; i += 2) {
      my[y[i]] = y[i + 1];
    }

    mx.forEach((k, v) {
      if (my.containsKey(k)) {
        if (mx[k] == my[k]) {
          this.score += 1;
        } else {
          print("DIFF $k => ${mx[k]} , ${my[k]}");
        }
      }
    });
    print("TOTAL SCORE: $score");
  }
}

void main() {
  CacheResult c = CacheResult();
  c.init();
  // for (var i = 1; i < 101; i++) {
  //   c.save("TEST",i, "A");
  // }
  c.compare("TEST", "RESULT");
}
