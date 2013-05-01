%% @author Ankit Tyagi
%% @doc Loader that initializes and spawns workers

-module(loader).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start/0, init/0]).

start() ->
	register(load, spawn(loader, init, [])).

init(LoadTestType) ->
	process_flag(trap_exit, true).
	%TODO: use mongo driver to pull data config on how to start creating processe	

%% ====================================================================
%% Internal functions
%% ====================================================================

loop(Data) ->
	receive
		{request, Pid, spawn_new, Count} ->
			% messaged a request, with Pid, saying to spawn 'Count' new processes
			%TODO: reply back with a Pid here
		
	end.

reply(Pid, Message) ->
	Pid ! {self(), Message}.
