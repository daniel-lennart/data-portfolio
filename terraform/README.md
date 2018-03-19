# Terraform

Terraform code to provision CPU or GPU AWS instances for [fast.ai deep learning course](fast.ai)

## Getting Started

The structure of this Terraform repository loosely follows the [published Hashicorp best practices](https://github.com/hashicorp/best-practices).

Also note that for API access to AWS accounts, use API access credentials in a [following manner](https://www.terraform.io/docs/providers/aws/#environment-variables).

# Usage

To install locally terraform from Hashicorp

Run:
```
make
```

# Maintenance

- One directory per environment to manage

# Using to build CPU instance

Plan the run:
```
make cpu_plan
```

Apply the configuration:
```
make cpu_apply
```

Destroy the entire environment:
```
make cpu_destroy
```

# Building CPU instance

Plan the run:
```
make cpu_plan
```

Apply the configuration:
```
make cpu_apply
```

Destroy the entire environment:
```
make cpu_destroy
```

# Building GPU instance

Plan the run:
```
make gpu_plan
```

Apply the configuration:
```
make gpu_apply
```

Destroy the entire environment:
```
make gpu_destroy
```
