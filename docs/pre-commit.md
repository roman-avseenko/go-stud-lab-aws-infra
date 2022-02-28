# About pre-commit

**pre-commit** is a framework for managing and maintaining multi-language pre-commit hooks.
For more detailed documentation check [their official website](https://pre-commit.com/#introduction).

## Setup pre-commit

1. Install **pre-commit** on your linux machine (for other OS refer to [official docs](https://pre-commit.com/#install)):
```bash
pip3 install pre-commit
```

2. Install **pre-commit** hooks (configuration is within __.pre-commit-config.yaml__ file):
```bash
pre-commit install
```

After that, pre-commit hook will be installed. For manual hooks execution issue command provided below.
```bash
pre-commit run -a
```

