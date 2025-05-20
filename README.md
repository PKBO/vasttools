# docker_report.sh

Tento repozitář obsahuje skript `docker_report.sh`, který slouží k rychlému přehledu o využití Docker kontejnerů, image a build cache na vašem systému.

## Co skript umí

Po spuštění zobrazí:

1. **Běžící kontejnery** (seřazené podle velikosti)
2. **Zastavené kontejnery** (seřazené podle velikosti)
3. **Docker image** (seřazené podle velikosti)
4. **Celkovou velikost build cache**
5. **Položky build cache** (seřazené podle velikosti)

## Rychlé použití

Na cílovém serveru nebo počítači spusťte tyto příkazy:

```bash
wget https://raw.githubusercontent.com/PKBO/vastdockersize/main/docker_report.sh
chmod +x docker_report.sh
./docker_report.sh
```

Pokud používáte jinou větev než `main`, upravte adresu v `wget`.

## Požadavky

- Bash shell
- Docker nainstalovaný a dostupný v příkazové řádce
- Povolený příkaz `docker builder df` (Docker 19.03+)

## Výstup

Skript vypíše přehledné tabulky a souhrny přímo do terminálu.

## Autor

[PKBO](https://github.com/PKBO)

# docker_report.sh

This repository contains the `docker_report.sh` script, which provides a quick overview of Docker container, image, and build cache usage on your system.

## What the script does

After running, you will see:

1. **Running containers** (sorted by size)
2. **Stopped containers** (sorted by size)
3. **Docker images** (sorted by size)
4. **Total build cache size**
5. **Build cache entries** (sorted by size)

## Quick usage

On your target server or computer, run these commands:

```bash
wget https://raw.githubusercontent.com/PKBO/vastdockersize/main/docker_report.sh
chmod +x docker_report.sh
./docker_report.sh
```

If you are using a branch other than `main`, change the branch name in the `wget` URL accordingly.

## Requirements

- Bash shell
- Docker installed and available from the command line
- The `docker builder df` command enabled (Docker 19.03+)

## Output

The script prints clear tables and summaries directly to the terminal.

## Author

[PKBO](https://github.com/PKBO)
