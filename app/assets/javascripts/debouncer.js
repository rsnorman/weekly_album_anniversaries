function debounce(debouncedFunction, debounceDuration) {
  var debounceTimer;
  return function() {
    var args;
    args = arguments;
    if (debounceTimer) {
      clearTimeout(debounceTimer);
      debounceTimer = null;
    }

    debounceTimer = setTimeout(function() {
      debounceTimer = null;
      debouncedFunction.apply(null, args);
    }, debounceDuration);
  };
}
