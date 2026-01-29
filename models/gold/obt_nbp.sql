{% set congigs = [
    {
        "table" : "NBP.SILVER.SILVER_NBP",
        "columns" : "SILVER_NBP.*",
        "alias" : "SILVER_NBP"
    }
] %}



SELECT 
    {% for config in congigs %}
        {{ config['columns'] }}{% if not loop.last %},{% endif %}
    {% endfor %}
FROM
    {% for config in congigs %}
    {% if loop.first %}
      {{ config['table'] }} AS {{ config['alias'] }}
    {% else %}
        LEFT JOIN {{ config['table'] }} AS {{ config['alias'] }}
        ON {{ config['join_condition'] }}
    {% endif %}
        {% endfor %}