#include <bits/stdc++.h>

using namespace std;

#define _ ios_base::sync_with_stdio(0);cin.tie(0);
#define endl '\n'

typedef long long ll;

const int INF = 0x3f3f3f3f;
const ll LINF = 0x3f3f3f3f3f3f3f3fll;

int main() {

  string line;

  int acc = 0, acc2 = 0;

  char e, p;

  map<char, int> scores =
    {{'X', 1}, {'Y', 2}, {'Z', 3}, // part 1
     {'A', 1}, {'B', 2}, {'C', 3}}; // part 2

  while (cin >> e >> p) {
    acc += scores[p];

    if (e == 'A' && p == 'Y') acc += 6;
    if (e == 'B' && p == 'Z') acc += 6;
    if (e == 'C' && p == 'X') acc += 6;

    if (e == 'A' && p == 'X') acc += 3;
    if (e == 'B' && p == 'Y') acc += 3;
    if (e == 'C' && p == 'Z') acc += 3;

    // Part 2
    if (p == 'Y') {
      acc2 += 3;
      acc2 += scores[e];
    } else if (p == 'Z') {
      acc2 += 6;
      if (e == 'A') acc2 += scores['B'];
      if (e == 'B') acc2 += scores['C'];
      if (e == 'C') acc2 += scores['A'];
    } else {
      if (e == 'A') acc2 += scores['C'];
      if (e == 'B') acc2 += scores['A'];
      if (e == 'C') acc2 += scores['B'];
    }
  }

  cout << acc << endl;

  cout << acc2 << endl;
  
  return 0;
}
