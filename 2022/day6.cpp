#include <bits/stdc++.h>

using namespace std;

#define _ ios_base::sync_with_stdio(0);cin.tie(0);
#define endl '\n'

typedef long long ll;

const int INF = 0x3f3f3f3f;
const ll LINF = 0x3f3f3f3f3f3f3f3fll;

bool checker (string marker) {
  for (int i = 0; i < marker.size() - 1; i++) {
    for (int j = i + 1; j < marker.size(); j++) {
      if (marker[i] == marker[j]) return false;
    }
  }
  return true;
}

int main() {

  string buffer;

  cin >> buffer;

  stringstream s(buffer);

  // Part 1
  char cs[4];
  int count = 4;
  set<char> marker;

  s >> cs[0] >> cs[1] >> cs[2] >> cs[3];
  for (auto c : cs) marker.insert(c);
  if (marker.size() < 4) {
    do{
      count++;
      cs[0] = cs[1];
      cs[1] = cs[2];
      cs[2] = cs[3];
      s >> cs[3];
      marker.clear();
      for (auto c : cs) marker.insert(c);
    } while (marker.size() < 4);
  }

  cout << count << endl;

  // Part 2

  string message_marker;

  int index;
  for (index = 0; message_marker.size() != 14 || !checker(message_marker); index++) {
    message_marker = buffer.substr(index, 14);
  }

  cout << index + 13 << endl;

  return 0;
}
