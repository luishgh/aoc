#use "helpers.ml";;
(*Day 1: Not Quite Lisp*)

let initial_floor = 0

type movement = Up | Down

let read_movement char =
  match char with
  | '(' -> Up
  | ')' -> Down
  | _ -> assert false

let match_movement input =
  match input with
  | Up -> 1
  | Down -> -1

let calculate_movements input =
  input
  |> explode
  |> List.map read_movement

let calculate_floor input =
  input
  |> List.map match_movement
  |> List.fold_left (+) 0

let final_floor input =
  input
  |> calculate_movements
  |> calculate_floor

let part1_answer =
  read_whole_file "day1.txt"
  |> String.trim
  |> final_floor

(* Part 2*)

let rec find_position floor position list =
  let new_floor = floor + List.nth list (position - 1) in
  match new_floor with
  | -1 -> position
  | _ -> find_position new_floor (position + 1) list

let basement_position input =
  input
  |> calculate_movements
  |> List.map match_movement
  |> find_position 0 1

let part2_answer =
  read_whole_file "day1.txt"
  |> String.trim
  |> basement_position
