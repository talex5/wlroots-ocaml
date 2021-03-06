open Ctypes
open Wlroots_common.Utils

module Bindings = Wlroots_ffi_f.Ffi.Make (Generated_ffi)
module Types = Wlroots_ffi_f.Ffi.Types

type t = Types.Backend.t ptr
include Ptr

let autocreate dpy =
  let b = Bindings.wlr_backend_autocreate dpy in
  if is_null b then failwith "Failed to create backend";
  b

let start = Bindings.wlr_backend_start
let destroy = Bindings.wlr_backend_destroy

let get_renderer = Bindings.wlr_backend_get_renderer

let signal_new_output (backend: t) : Types.Output.t ptr Wl.Signal.t = {
  c = backend |-> Types.Backend.events_new_output;
  typ = ptr Types.Output.t;
}

let signal_new_input (backend: t) : Types.Input_device.t ptr Wl.Signal.t = {
  c = backend |-> Types.Backend.events_new_input;
  typ = ptr Types.Input_device.t;
}
