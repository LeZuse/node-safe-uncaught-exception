# Safe uncaught exception
Simple helper function for better handling or the uncaughtException event

## Why safe?
Solves the problem when there are other listeners for uncaughtException
calling process.exit, hence circumventing your own listener
