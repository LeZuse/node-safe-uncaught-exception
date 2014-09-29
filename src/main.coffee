
###
  @param listener Function to handle the Exception
  @param [timeout] Give listener given amount time to execute, then call other listeners
###
module.exports.onUncaughtException = (listener, timeout) ->
  delayNextListeners process, 'uncaughtException', (if timeout then timeout else 3000), listener

delayNextListeners = (emitter, event, delay, listener) ->
  orig = emitter._events[event]
  next = (err) ->
    setTimeout ->
      # NOTE: we might loose err context?
      if orig
        orig.map (l) -> l err
      else
        # Execution after uncaughtException is very unsafe
        process.exit -1
    , delay
  emitter._events[event] = [listener, next]
