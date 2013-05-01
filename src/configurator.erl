-module(configurator).
-define(MONGO_HOST, "localhost").
-define(MONGO_PORT, "27017").
-export([create_config/3]).

create_config(WorkerModule, WorkerFunction, Key) ->
	ok = init_bson_mongo(),
	Host = {?MONGO_HOST, ?MONGO_PORT},
	{ok, Conn} = mongo:connect(Host),
	insert(Conn, Key, {WorkerModule, WorkerFunction}).


insert(Conn, Key, Data) ->
	mongo:do(safe, slave_ok, Conn, loadTest, fun() ->
		mongo:insert(configs, {key,Key, data, Data}) 
	end).



init_bson_mongo() ->
	application:start(bson),
	application:start(mongodb).

