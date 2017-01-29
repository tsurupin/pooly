defmodule Pooly.WorkerSupervisor do
  use Supervisor

  def start_link({_,_,_} = mfa) do
    Supervisor.start_link(__MODULE__, mfa)
  end

  def init({m,f,a}) do
    # restart -> Specifies that the worker is always to be restarted
    # function -> Specifies the function to start the worker
    worker_opts = [restart: :permanent, function: f]
    # Creates a list of the child processes
    children = [worker(m,a, worker_opts)]
    # Specifies the options for the supervisor
    opts = [strategy: :simple_one_for_one,
            max_restarts: 5,
            max_seconds: 5]
    # Helper function to create the child specification
    supervise(children, opts)
  end
end
