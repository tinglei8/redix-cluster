# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
# copy from redix.ex

# ## Options

# ### Redis options

# The following options can be used to specify the parameters used to connect to
# Redis (instead of a URI as described above):

#   * `:host` - (string) the host where the Redis server is running. Defaults to
#     `"localhost"`.

#   * `:port` - (positive integer) the port on which the Redis server is
#     running. Defaults to `6379`.

#   * `:password` - (string) the password used to connect to Redis. Defaults to
#     `nil`, meaning no password is used. When this option is provided, all Redix
#     does is issue an `AUTH` command to Redis in order to authenticate.

#   * `:database` - (non-negative integer or string) the database to connect to.
#     Defaults to `nil`, meaning Redix doesn't connect to a specific database (the
#     default in this case is database `0`). When this option is provided, all Redix
#     does is issue a `SELECT` command to Redis in order to select the given database.

# ### Connection options

# The following options can be used to tweak how the Redix connection behaves.

#   * `:socket_opts` - (list of options) this option specifies a list of options
#     that are passed to `:gen_tcp.connect/4` when connecting to the Redis
#     server. Some socket options (like `:active` or `:binary`) will be
#     overridden by Redix so that it functions properly. Defaults to `[]`.

#   * `:timeout` - (integer) connection timeout (in milliseconds) also directly
#     passed to `:gen_tcp.connect/4`. Defaults to `5000`.

#   * `:sync_connect` - (boolean) decides whether Redix should initiate the TCP
#     connection to the Redis server *before* or *after* returning from
#     `start_link/1`. This option also changes some reconnection semantics; read
#     the "Reconnections" page in the docs.

#   * `:exit_on_disconnection` - (boolean) if `true`, the Redix server will exit
#     if it fails to connect or disconnects from Redis. Note that setting this
#     option to `true` means that the `:backoff_initial` and `:backoff_max` options
#     will be ignored. Defaults to `false`.

#   * `:backoff_initial` - (non-negative integer) the initial backoff time (in milliseconds),
#     which is the time that the Redix process will wait before
#     attempting to reconnect to Redis after a disconnection or failed first
#     connection. See the "Reconnections" page in the docs for more information.

#   * `:backoff_max` - (positive integer) the maximum length (in milliseconds) of the
#     time interval used between reconnection attempts. See the "Reconnections"
#     page in the docs for more information.

#   * `:log` - (keyword list) a keyword list of `{action, level}` where `level` is
#     the log level to use to log `action`. The possible actions and their default
#     values are:
#       * `:disconnection` (defaults to `:error`) - logged when the connection to
#         Redis is lost
#       * `:failed_connection` (defaults to `:error`) - logged when Redix can't
#         establish a connection to Redis
#       * `:reconnection` (defaults to `:info`) - logged when Redix manages to
#         reconnect to Redis after the connection was lost

#   * `:name` - Redix is bound to the same registration rules as a `GenServer`. See the
#     `GenServer` documentation for more information.

#   * `:ssl` - (boolean) if `true`, connect through SSL, otherwise through TCP. The
#     `:socket_opts` option applies to both SSL and TCP, so it can be used for things
#     like certificates. See `:ssl.connect/4`. Defaults to `false`.

#   * `:sentinel` - (keyword list) options for using
#     [Redis Sentinel](https://redis.io/topics/sentinel). If this option is provided, then the
#     `:host` and `:port` option cannot be provided. For the available sentinel options, see the
#     "Sentinel options" section below.

# ### Sentinel options

# The following options can be used to configure the Redis Sentinel behaviour when connecting.
# These options should be passed in the `:sentinel` key in the connection options. For more
# information on support for Redis sentinel, see the `Redix` module documentation.

#   * `:sentinels` - (list) a list of sentinel addresses. Each element in this list is the address
#     of a sentinel to be contacted in order to obtain the address of a primary. The address of
#     a sentinel can be passed as a Redis URI (see the "Using a Redis URI" section above) or
#     a keyword list with `:host`, `:port`, `:password` options (same as when connecting to a
#     Redis instance direclty). Note that the password can either be passed in the sentinel
#     address or globally -- see the `:password` option below. This option is required.

#   * `:group` - (binary) the name of the group that identifies the primary in the sentinel
#     configuration. This option is required.

#   * `:role` - (`:primary` or `:replica`) if `:primary`, the connection will be established
#     with the primary for the given group. If `:replica`, Redix will ask the sentinel for all
#     the available replicas for the given group and try to connect to one of them **at random**.
#     Defaults to `:primary`.

#   * `:socket_opts` - (list of options) the socket options that will be used when connecting to
#     the sentinels. Defaults to `[]`.

#   * `:ssl` - (boolean) if `true`, connect to the sentinels via through SSL, otherwise through
#     TCP. The `:socket_opts` applies to both TCP and SSL, so it can be used for things like
#     certificates. See `:ssl.connect/4`. Defaults to `false`.

#   * `:timeout` - (timeout) the timeout (in milliseconds or `:infinity`) that will be used to
#     interact with the sentinels. This timeout will be used as the timeout when connecting to
#     each sentinel and when asking sentinels for a primary. The Redis documentation suggests
#     to keep this timeout short so that connection to Redis can happen quickly.

#   * `:password` - (string) if you don't want to specify a password for each sentinel you
#     list, you can use this option to specify a password that will be used to authenticate
#     on sentinels if they don't specify a password. This option is recommended over passing
#     a password for each sentinel because in the future we might do sentinel auto-discovery,
#     which means authentication can only be done through a global password that works for all
#     sentinels.

config :redix_cluster,
  cluster_nodes: [%{host: "127.0.0.1", port: 7000},
                  %{host: "127.0.0.1", port: 7001},
                  %{host: "127.0.0.1", port: 7002}
                 ],
  pool_size: 5,
  pool_max_overflow: 0,

# connection_opts
  socket_opts: [],
  backoff_initial: 2000,
  backoff_max: 2000

#
# And access this configuration in your application as:
#
#     Application.get_env(:redix_cluster, :key)
#
# Or configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
 import_config "#{Mix.env}.exs"
