#load "str.cma";;

let explode s = List.init (String.length s) (String.get s)

let read_whole_file filename =
    let ch = open_in filename in
    let s = really_input_string ch (in_channel_length ch) in
    close_in ch;
    s

let list_max = function 
  | x::xs -> List.fold_left max x xs
  | _ -> assert false

let list_min = function 
  | x::xs -> List.fold_left min x xs
  | _ -> assert false

(*FIXME: apparently this doesnt work*)
let parse_file file f =
  let ic = open_in file in
  let try_read () =
    try Some (input_line ic) with End_of_file -> None in
  let rec loop acc =
    match try_read () with
    | Some s -> loop (f (String.trim s) :: acc)
    | None -> close_in ic; List.rev acc
  in
  loop []
