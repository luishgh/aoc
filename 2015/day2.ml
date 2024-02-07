#use "helpers.ml";;
#load "str.cma";;
(*Day 2: I Was Told There Would Be No Math*)

(* Notes *)

(*length l, width 2 and height h*)

(*surface are of present: 2*l*w + 2*w*h + 2*h*l*)

(*extra paper: smallest surface area*)

type present =
  { length : int;
    width: int;
    height: int;
  }

let make_present l w h =
  { length = l;
    width = w;
    height = h;
  }

let parse_present present_string =
  let r = Str.regexp {|\([0-9]+\)x\([0-9]+\)x\([0-9]+\)|} in
  ignore (Str.string_match r present_string 0);
  make_present
    (int_of_string (Str.matched_group 1 present_string))
    (int_of_string (Str.matched_group 2 present_string))
    (int_of_string (Str.matched_group 3 present_string));;

let surface_area (p: present) =
  2*p.length*p.width,
  2*p.width*p.height,
  2*p.height*p.length

let extra_paper surface_area =
  let (l, w, h) = surface_area in
  (list_min [l; w; h])/2

let add_extra_paper surface_area =
  let ep = extra_paper surface_area in
  let (l, w, h) = surface_area in
  [l; w; h; ep]

let wrapping_paper p =
  p
  |> surface_area
  |> add_extra_paper
  |> List.fold_left (+) 0

let total_wrapping_paper =
  parse_file "day2.txt" parse_present
  |> List.map wrapping_paper
  |> List.fold_left (+) 0

(* Part 2 *)

(* ribbon = the smallest perimeter of any one face (2*smallest_side + 2*second_smallest)
   +
   bow    = volume of the present*)

let present_bow p =
  p.length * p.width * p.height

let smallest_perimeter p =
  let {length; width; height} = p in
  let sorted_dimensions = List.sort compare [length; width; height] in
  2*(List.nth sorted_dimensions 0) + 2*(List.nth sorted_dimensions 1)

let extra_ribbon p =
  smallest_perimeter p + present_bow p

let total_extra_ribbon =
  parse_file "day2.txt" parse_present
  |> List.map extra_ribbon
  |> List.fold_left (+) 0
