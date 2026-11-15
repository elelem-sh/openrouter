# elelem-openrouter

An [OpenRouter](https://openrouter.ai/settings/keys) provider plugin for [elelem](https://elelem.sh).
It talks to OpenRouter's OpenAI-compatible Chat Completions API
through [elelem-openai](https://github.com/elelem-sh/openai).

## Install

```sh
gem install elelem-openrouter
```

## Use

```sh
export OPENROUTER_API_KEY=...
elelem -p openrouter --model MODEL
```

* `OPENROUTER_API_KEY` (required): get one at https://openrouter.ai/settings/keys
* `OPENROUTER_MODEL`: the model, when `--model` is not given
* `OPENROUTER_BASE_URL`: overrides `https://openrouter.ai/api/v1`

There is no default model, since free model lists change often. With
no model set, elelem stops and names `OPENROUTER_MODEL`. A variable that is
set but empty counts as unset.

Free tier limits are on OpenRouter's own page: https://openrouter.ai/docs/api/reference/limits

## Development

```sh
bin/setup
bin/test
bin/lint
```

## License

MIT. See LICENSE.txt.
