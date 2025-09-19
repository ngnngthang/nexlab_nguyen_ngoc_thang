String buildQueryString(Map<String, dynamic>? queryParameters) {
  if (queryParameters == null || queryParameters.isEmpty) return '';

  final queryString = queryParameters.entries
      .map(
        (entry) =>
            '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}',
      )
      .join('&');

  return '?$queryString';
}
