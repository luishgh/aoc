#include <bits/stdc++.h>

using namespace std;

#define _ ios_base::sync_with_stdio(0);cin.tie(0);
#define endl '\n'

typedef long long ll;

const int INF = 0x3f3f3f3f;
const ll LINF = 0x3f3f3f3f3f3f3f3fll;

int main() {

  string line;
  int acc = 0;
  vector<int> elves;

  while (getline(cin, line)) {
    line.erase(remove_if(line.begin(), line.end(), ::isspace), line.end());
    if (line.empty()) {
      elves.push_back(acc);
      acc = 0;
      continue;
    }

    acc += stoi(line);
  }

  sort(elves.begin(), elves.end(), ::greater<int>());

  cout << elves.front() << endl;

  acc = 0;
  for (int i = 0; i < 3; i++) acc += elves[i];
  cout << acc << endl;

  return 0;
}
