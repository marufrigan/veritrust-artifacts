# VeriTrust Artifacts (v0.1.0 – Conceptual Scaffold)

This repository provides **reproducibility artifacts** for the VeriTrust framework:
- Docker/Compose **templates** (commented) for Besu, Indy/Aries, and IPFS
- A minimal **Solidity** contract sketch for content anchoring
- An **offline verifier stub** (Python) to verify SHA-256 content hash + Merkle inclusion
- Sample **W3C VC/VP** JSON, provenance record, and **Merkle proof** JSON
- A small **sample dataset** for demonstration

> **Scope**: These artifacts are **illustrative** (conceptual). They are not production-ready and do not stand up a working network. They are intended to support **paper reproducibility** by demonstrating data formats, contract interfaces, and verification logic.

## Quick Start (offline verifier)
1. Install Python 3.10+
2. `cd verifier-stub && pip install -r requirements.txt`
3. `python verify.py`
You should see a pass/fail message verifying:
- SHA-256 hash of a sample content string
- Inclusion of the content leaf in a sample Merkle root using a provided proof

## What’s here (overview)
- `docker-compose.yml`: commented templates for Besu, Indy/Aries, and IPFS (not executed by default).
- `contracts/ContentRegistry.sol`: minimal contract illustrating content anchoring events/ABI surface.
- `verifier-stub/verify.py`: offline checker (no blockchain calls).
- `data/*`: sample dataset, provenance record, VC/VP, Merkle proof (JSON).
- `docs/*`: notes on architecture, security, and limitations.

## Roadmap
- v0.2.x: add compileable contract + ABI, minimal local unit tests
- v0.3.x: optional local demo networks (Besu dev, Indy test pool)

**Data Availability:** https://github.com/marufrigan/veritrust-artifacts (release v0.1.0)
