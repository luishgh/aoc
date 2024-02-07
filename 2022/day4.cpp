#include <bits/stdc++.h>

using namespace std;

#define _ ios_base::sync_with_stdio(0);cin.tie(0);
#define endl '\n'

typedef long long ll;

const int INF = 0x3f3f3f3f;
const ll LINF = 0x3f3f3f3f3f3f3f3fll;

typedef pair<unsigned int, unsigned int> Interval;

void parse_interval(string s, Interval& p) {

  stringstream stream(s);

  stream >> p.first;
  stream.ignore();
  stream >> p.second;
}

int main() {

  string line;

  int count = 0;
  int count2 = 0;

  while (getline(cin, line)) {
    stringstream s(line);

    Interval elves[2];

    string first; getline(s, first, ',');
    parse_interval(first, elves[0]);

    string second; getline(s, second);
    parse_interval(second, elves[1]);

    if (elves[0].first <= elves[1].first && elves[0].second >= elves[1].second) count++;
    else if (elves[1].first <= elves[0].first && elves[1].second >= elves[0].second) count++;

    if (!(elves[0].first < elves[1].first && elves[0].second < elves[1].first || elves[1].first < elves[0].first && elves[1].second < elves[0].first)) count2++;
  }

  cout << count << endl;
  cout << count2 << endl;

  return 0;
}
