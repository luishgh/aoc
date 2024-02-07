#use "helpers.ml";;
(*Day 3: Perfectly Spherical Houses in a Vacuum*)

module Point: 
  sig
    type t = Point of int * int
    val compare: t -> t -> int
    val make_point: int -> int -> t
    val move_point: char -> t -> t
  end = struct
    type t = Point of int * int
    let compare = Stdlib.compare
    let make_point h v = Point (h,v)
    let move_point char (Point (h,v)) =
      match char with
      | '>' -> make_point (h + 1) v
      | '<' -> make_point (h - 1) v
      | '^' -> make_point  h (v + 1)
      | 'v' -> make_point  h (v - 1)
      | _ -> assert false
  end

open Point

let add_point points movement =
  (move_point movement (List.hd points)) :: points 

let read_movements movements =
  movements
  |> explode
  |> List.fold_left add_point [(make_point 0 0)]
  |> List.sort_uniq Point.compare

let total_houses =
  read_whole_file "day3.txt"
  |> String.trim
  |> read_movements
  |> List.length

(* Part 2 *)

let segregate_movements movements =
  let moves = explode movements in
  let santa_moves =
    List.filteri (fun i _ -> i mod 2 == 0) moves in
  let robo_moves =
    List.filteri (fun i _ -> i mod 2 != 0) moves in
  List.combine santa_moves robo_moves

let read_movement_pair (santa_move, robo_move) (santa_movements,robo_movements) =
  move_point santa_move santa_movements,
  move_point robo_move robo_movements

let read_santas_movements movements =
  segregate_movements movements
  |> List.fold_left
       (fun moves move_pair -> (read_movement_pair move_pair (List.hd moves)) :: moves)
       [(make_point 0 0), (make_point 0 0)]
  |> List.fold_left (fun acc (x,y) -> x :: y :: acc) []
  |> List.sort_uniq Point.compare

let total_houses_electric_boogaloo =
  read_whole_file "day3.txt"
  |> String.trim
  |> read_santas_movements
  |> List.length
