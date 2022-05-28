# Gnosis Beacon Chain - Docker

Supported operating systems: Linux (Ubuntu, Debian, etc.)

Provides multiple `docker-compose` environments for running a Gnosis Beacon Chain validator, with minimal configuration needed.

### Currently supported nodes:
Gnosis Chain: Nethermind, Openethereum (backup)<br>
Gnosis Beacon Chain: Prysm, Lighthouse

## Installation

1. Install docker and docker-compose:
    - On [Ubuntu 22.04](https://releases.ubuntu.com/22.04/), run: `sudo apt update && sudo apt install docker.io docker-compose`
    - On any other Linux distro, follow these instructions: https://docs.docker.com/get-docker/ and https://docs.docker.com/compose/install/


2. Download this repository:
    - Run: `git clone https://github.com/gimlucom/gnosis-beacon-chain-docker.git`
    - Or download and extract the .zip file: https://github.com/gimlucom/gnosis-beacon-chain-docker/archive/refs/heads/master.zip

## Usage

1. Enter into the repository directory, i.e. run `cd gnosis-beacon-chain-docker`


2. Generate your validator keys or add existing keys.
   - To generate new keys: Replace "YOUR-ETHEREUM-ADDRESS" with your own Ethereum address, preferably one secured by a hardware wallet or cold storage, then run the following command:
   ```bash
   sudo docker run -it --rm -v $(pwd)/keys/validator_keys:/app/validator_keys ghcr.io/gnosischain/validator-data-generator:latest new-mnemonic --num_validators=4 --chain=gnosis --folder=/app/validator_keys --eth1_withdrawal_address=YOUR-ETHEREUM-ADDRESS
   ```
   - To import your existing keys: copy your keystores into the `./keys/validator_keys/` folder.


3. Select the beacon chain client you want to use, Prysm or Lighthouse, and enter into its directory, i.e. run `cd prysm` or `cd lighthouse`


4. Import your validator keys, this only has to be done once:
   ```bash
   sudo docker-compose up validator-import
   ```

5. Start your node and validator:
   ```bash
   sudo docker-compose up -d
   ```

View the logs (exit using ctrl+c):
```bash
sudo docker-compose logs -f --tail 500
```

## Advanced options

These additional configurations replaces "Step 5".

To also run OpenEthereum in addition to Nethermind for Gnosis Chain:
```bash
sudo docker-compose --profile gc-backup up -d
```

Run a slasher:
```bash
sudo docker-compose --profile private-slasher up -d
```

You may also choose multiple configurations by combining them, example:
```bash
sudo docker-compose --profile oe-backup --profile private-slasher up -d
```



`$ docker-compose up`

A `.lighthouse` directory will be created in the repository root which contains
the validator keys, beacon node database and other Lighthouse files.


## Validator deposit

1. Generate validator keys

```bash

```


## Configuration

The docker-compose file requires that a `.env` file be present in this
directory. The `default.env` file provides a template and can be copied `.env`:

```bash
$ cp default.env .env
```

Failure to create an `.env` file will result in the following error:

```
ERROR: Couldn't find env file: /home/karlm/lighthouse-docker/.env
```