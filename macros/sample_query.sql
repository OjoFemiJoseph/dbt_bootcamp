{% macro sample_macro() %}
  {{ log("This is a sample message from sample_macro", info=True) }}
{% endmacro %}



{% macro check_sanity() %}

    {% if execute %}

        {% set args = invocation_args_dict or {} %}

        {% set selected = args.get("select") or args.get("models") %}

        {% if not selected %}
            {{ exceptions.raise_compiler_error("Wos, Wobi, If i catch you. Use --select or --models to scope your run.") }}
        {% endif %}

    {% endif %}

{% endmacro %}
