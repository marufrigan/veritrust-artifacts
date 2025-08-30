import hashlib, json, os

DATA_DIR = os.path.join(os.path.dirname(__file__), "..", "data")

def sha256_hex(b: bytes) -> str:
    return hashlib.sha256(b).hexdigest()

def concat_hash(a_hex: str, b_hex: str) -> str:
    a = bytes.fromhex(a_hex)
    b = bytes.fromhex(b_hex)
    return hashlib.sha256(a + b).hexdigest()

def verify_merkle_inclusion(leaf_hex: str, proof_hex_list, root_hex: str, leaf_index: int) -> bool:
    curr = leaf_hex
    idx = leaf_index
    for sib in proof_hex_list:
        if idx % 2 == 0:
            curr = concat_hash(curr, sib)
        else:
            curr = concat_hash(sib, curr)
        idx //= 2
    return curr == root_hex

def main():
    with open(os.path.join(DATA_DIR, "sample_provenance_record.json")) as f:
        prov = json.load(f)
    with open(os.path.join(DATA_DIR, "sample_merkle_proof.json")) as f:
        proof = json.load(f)

    content = prov["content"]["raw_example"].encode("utf-8")
    computed_leaf = sha256_hex(content)
    expected_leaf = prov["content"]["sha256_hex"]

    print(f"[1] Content SHA-256: {computed_leaf}")
    print(f"    Expected leaf  : {expected_leaf}")
    if computed_leaf != expected_leaf:
        print("FAIL: content hash mismatch")
        return

    ok = verify_merkle_inclusion(
        leaf_hex=expected_leaf,
        proof_hex_list=proof["sibling_hashes"],
        root_hex=proof["merkle_root"],
        leaf_index=proof["leaf_index"]
    )
    print(f"[2] Merkle inclusion -> {ok}")
    print("[OK] Offline verification completed." if ok else "[FAIL] Merkle inclusion failed.")

if __name__ == "__main__":
    main()
