\name{startDaemonizedServer}
\alias{startDaemonizedServer}
\title{Create an HTTP/WebSocket daemonized server (experimental)}
\usage{
  startDaemonizedServer(host, port, app)
}
\arguments{
  \item{host}{A string that is a valid IPv4 address that is
  owned by this server, or \code{"0.0.0.0"} to listen on
  all IP addresses.}

  \item{port}{A number or integer that indicates the server
  port that should be listened on. Note that on most
  Unix-like systems including Linux and Mac OS X, port
  numbers smaller than 1025 require root privileges.}

  \item{app}{A collection of functions that define your
  application. See Details.}
}
\value{
  A handle for this server that can be passed to
  \code{\link{stopDaemonizedServer}} to shut the server
  down.
}
\description{
  Creates an HTTP/WebSocket server on the specified host
  and port. The server is daemonized so R interactive
  sessions are not blocked to handle requests.
}
\details{
  In contrast to servers created by
  \code{\link{startServer}}, calls to \code{\link{service}}
  are not needed to accept and handle connections. If the
  port cannot be bound (most likely due to permissions or
  because it is already bound), an error is raised.

  The \code{app} parameter is where your application logic
  will be provided to the server. This can be a list,
  environment, or reference class that contains the
  following named functions/methods:

  \describe{ \item{\code{call(req)}}{Process the given HTTP
  request, and return an HTTP response. This method should
  be implemented in accordance with the
  \href{https://github.com/jeffreyhorner/Rook/blob/a5e45f751/README.md}{Rook}
  specification.} \item{\code{onHeaders(req)}}{Optional.
  Similar to \code{call}, but occurs when headers are
  received. Return \code{NULL} to continue normal
  processing of the request, or a Rook response to send
  that response, stop processing the request, and ask the
  client to close the connection.  (This can be used to
  implement upload size limits, for example.)}
  \item{\code{onWSOpen(ws)}}{Called back when a WebSocket
  connection is established.  The given object can be used
  to be notified when a message is received from the
  client, to send messages to the client, etc. See
  \code{\link{WebSocket}}.} }

  The \code{startPipeServer} variant is not supported yet.
}
\seealso{
  \code{\link{startServer}}
}

