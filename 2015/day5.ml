#use "helpers.ml";;
#load "str.cma";;
(*Day 4: Doesn't He Have Intern-Elves For This?*)

(* Notes *)

(*
  A nice string is one with all of the following properties:
    - It contains at least three vowels (aeiou only)
    - It contains at least one letter that appears twice in a row
    - It does not contain the strings ab, cd, pq, or xy, even if they are part of one of the other requirements.
    
  Make a predicate function for each of the requirements and run a logical AND with all three
*)

let does_not_contain_bad_pairs s =
  let r = Str.regexp {|.*ab+.*\|.*cd+.*\|.*pq+.*\|.*xy+.*|} in
  Str.string_match r s 0
  |> not

let contains_three_or_more_vowels s =
  let r = Str.regexp {|[aeiou]|} in
  (Str.split_delim r s
   |> List.length) > 3

let contains_one_double_letter s =
  let r = Str.regexp {|.*\([a-z]\)\1+.*|} in
  Str.string_match r s 0

let nice_string s =
  does_not_contain_bad_pairs s
  && contains_three_or_more_vowels s
  && contains_one_double_letter s

let first_answer =
  read_whole_file "day5.txt"
  |> String.trim
  |> String.split_on_char '\n'
  |> List.filter nice_string
  |> List.length

(* Part 2 *)

let contains_one_double_letter_non_overlapping s =
  let r = Str.regexp {|.*\([a-z]\)\1+.*|} in
  ignore @@ Str.string_match r s 0;
  let group_start = Str.group_end 1 in
  if s.[group_start - 2] == s.[group_start -1] ||
       s.[group_start - 1] == s.[group_start] then
    false
  else
    true
