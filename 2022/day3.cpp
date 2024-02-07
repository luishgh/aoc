#include <bits/stdc++.h>

using namespace std;

#define _ ios_base::sync_with_stdio(0);cin.tie(0);
#define endl '\n'

typedef long long ll;

const int INF = 0x3f3f3f3f;
const ll LINF = 0x3f3f3f3f3f3f3f3fll;

int priority(char c) {
  if (islower(c)) return c - 'a' + 1;
  else return c - 'A' + 27;
}

int main() {

  string line;

  vector<int> priorities;

  stringstream input; input << cin.rdbuf();
  input.seekg(0);

  while(getline(input, line)) {
    int half = line.size()/2;
    string components[] = {line.substr(0, half), line.substr(half, line.size())};

    char item;
    for (auto c : components[0]) {
      if (components[1].find(c) != string::npos) {
        item = c;
        break;
      }
    }
    priorities.push_back(priority(item));
  }

  int acc = 0;
  for (auto p : priorities) acc += p;
  cout << acc << endl;

  // Part 2

  string lines[3];
  priorities.clear();
  input.clear();
  input.seekg(0);
  
  while(getline(input, lines[0]) && getline(input, lines[1]) && getline(input, lines[2])) {

    char item;
    for (auto c : lines[0]) {
      if ((lines[1].find(c) != string::npos) && (lines[2].find(c) != string::npos)) {
        item = c;
        break;
      }
    }
    priorities.push_back(priority(item));
  }

  acc = 0;
  for (auto p : priorities) acc += p;
  cout << acc << endl;

  return 0;
}
