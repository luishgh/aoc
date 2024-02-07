#use "helpers.ml";;
#load "str.cma";;
(*Day 4: The Ideal Stocking Stuffer*)

(* Notes *)

(*
  The Digest module provides MD5 hashing functions.
  Ex: 'Digest.string "abcdef609043" |> Digest.to_hex ;;`
*)

let puzzle_input = "ckczppom"

let candidate_hash candidate =
  let candidate = puzzle_input ^ (Int.to_string candidate) in
  Digest.string candidate
  |> Digest.to_hex

let get_answer prefix =
  let start = 0 in
  let rec get_answer' current_candidate =
    if String.starts_with ~prefix:prefix (candidate_hash current_candidate) then
      current_candidate
    else
      get_answer' (current_candidate + 1)
  in
  get_answer' start

let first_answer = get_answer
                     (Seq.repeat '0'
                      |> Seq.take 5
                      |> String.of_seq)

(* Part 2 *)

let second_answer = get_answer
                     (Seq.repeat '0'
                      |> Seq.take 6
                      |> String.of_seq)
