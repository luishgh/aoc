#include <bits/stdc++.h>

using namespace std;

#define _ ios_base::sync_with_stdio(0);cin.tie(0);
#define endl '\n'

typedef long long ll;

const int INF = 0x3f3f3f3f;
const ll LINF = 0x3f3f3f3f3f3f3f3fll;

int main() {

  vector<string> lines;

  int crates_num;
  while (true) {
    string line;
    getline(cin, line);

    if (line.find('1') != string::npos) {
      stringstream s(line);
      while (s >> crates_num);
      break;
    }
    lines.push_back(line);
  }

  vector<stack<char>> crates(crates_num);

  for (int i = lines.size() - 1; i >= 0; i--) {
    string line = lines[i];

    for (int index = 0; (index = line.find(']', index)) != string::npos;) {
      crates[(index - 2)/4].push(line[index-1]);
      index++;
    }
  }

  string line; getline(cin, line);

  vector<stack<char>> crates2 = crates;

  while (getline(cin , line)) {

    line.erase(remove_if(line.begin(), line.end(), ::isalpha), line.begin());

    stringstream s(line);
    int count, org, dest;
    s >> count >> org >> dest;
    org --; dest--;

    for (int i = 0; i < count; i++) {
      char m = crates[org].top(); crates[org].pop();
      crates[dest].push(m);
    }

    vector<char> moves;
    for (int i = 0; i < count; i++) {
      moves.push_back(crates2[org].top());
      crates2[org].pop();
    }

    reverse(moves.begin(), moves.end());
    for (auto v : moves) crates2[dest].push(v);
  }

  // Part 1
  for (auto stack : crates) cout << stack.top();
  cout << endl;

  // Part 2
  for (auto stack : crates2) cout << stack.top();
  cout << endl;
  
  return 0;
}
