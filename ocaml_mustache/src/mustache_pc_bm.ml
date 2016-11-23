let rec do_tests (template : Mustache.t) (bindings : Ezjsonm.t) (num : int) : unit =
  if num == 0 then ()
  else
    begin
      Mustache.render template bindings
      |> ignore;
      do_tests template bindings (num - 1)
    end


let load_file f =
  let ic = open_in f in
  let n = in_channel_length ic in
  let s = Bytes.create n in
  really_input ic s 0 n;
  close_in ic;
  (s)


let usage () =
  print_endline "Usage: $0 template_file bindings_file"


let () =
  match Sys.argv with
  | [| _ ; template_file; bindings_file; num_tests |] ->
      let template = Mustache.of_string (load_file template_file) in
      let bindings = Ezjsonm.from_string (load_file bindings_file) in
      let t1 = Unix.gettimeofday() in
      do_tests template bindings (int_of_string num_tests);
      let t2 = Unix.gettimeofday() in
      print_endline (string_of_float (t2 -. t1))
  | _ -> usage ()
