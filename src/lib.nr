use std::hash::pedersen_hash;

/*
Calculate the root pedersen hash of the merkle tree
*/
fn compute_merkle_root(leaf:Field,path_indices: [Field], siblings: [Field])->Field{
    let mut current = leaf;
    for i in 0..siblings.len(){
       let is_left = (path_indices[i] == 0) as bool;
       let (hash_left, hash_right) = if is_left {
            (current,siblings[i])
         } else {
            (siblings[i],current)
         };
        current = pedersen_hash([hash_left, hash_right]);
    }
    println(current);
    current
}

#[test]
fn test_compute_merkle_root() {
    let leaf = 0x1234567890abcdef;
    let path_indices = [0,0,1,1,0,1,1,0];
    let siblings = [0xab,0xcb,0xde,0xaf,0xac,0xec,0xaf,0xbe];
    let root = compute_merkle_root(leaf, path_indices, siblings);
    assert(root == 0x29ef6ef5c0b27c0a0957000decfd00918d50a209342e9eaaa32d8128945dc835);
}
