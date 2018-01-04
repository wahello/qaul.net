/* qaul.net - libqaul
 *
 * libqaul implements and uses many data structures to move data around
 * it's core components. While all external calls use a common msgpack
 * interface, internally only simple structures are used.
 *
 * These structures, types and enums are declared here. Each file in the
 * library can then include this file and have access to all datastructures
 * that are available in the library. This also avoids duplicating
 * functionality between two structures in two different modules.
 *
 * If this file get's too long it can be split up into smaller modules
 *
 * ----------------------------------------------------------------------------
 *
 * This program and the accompanying materials
 * are made available under the terms of the GNU Lesser General Public License
 * (LGPL) version 3 which accompanies this distribution, and is available at
 * http://www.gnu.org/licenses/lgpl-3.html
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 */


#ifndef QAUL_QLFORMAT_H
#define QAUL_QLFORMAT_H

/********************** GENERAL **********************/

// A simple value that can be checked against to make
// sure that a struct has been properly initialised
#include <glob.h>


#define QL_MODULE_INITIALISED 0x1337;


typedef enum ql_operation_t {

    // Cryptography operations
    ENCRYPT, DECRYPT, SIGN, VERIFY


} ql_operation_t;


/********************** USER MANAGEMENT **********************/


/**
 * A structure that contains user information
 */
typedef struct ql_user {
    char *username;
    char *fingerprint;
    struct ql_keypair *keypair;
} ql_user;


/**
 * Describes a piece of data attached to a user
 */
typedef enum ql_userdata_t {
    FINGERPRINT,
    PUBKEY,
} ql_userdata_t;


/********************** CRYPTO CORE **********************/


/** An enum that describes key types */
typedef enum ql_cipher_t {
    PK_RSA  = (1 << 1),
    ECDSA   = (1 << 2),
    AES256  = (1 << 3),
    NONE    = (1 << 4)
} ql_cipher_t;


/**
 * Contains the key sizes for different types
 */
static int QL_KEYLENGTHS[] = { 2048, 192, 256 };


/**
 * A structure that contains a public key
 *
 * The actual key formatting is specific to an implemetation
 * and as such shadowed to the outside. The crypto module will
 * cast the blob to whatever format is required at the time
 */
typedef struct ql_pubkey {
    enum ql_cipher_t type;
    void *blob;
} ql_pubkey;


/**
 * A structure that contains a secret (private) key
 *
 * The actual key formatting is specific to an implemetation
 * and as such shadowed to the outside. The crypto module will
 * cast the blob to whatever format is required at the time
 */
typedef struct ql_seckey {
    enum ql_cipher_t type;
    void *blob;
} ql_seckey;


/**
 * A structure that contains a complete user keypair
 */
typedef struct ql_keypair {
    enum ql_cipher_t type;
    struct ql_pubkey *pub;
    struct ql_seckey *sec;
} ql_keypair;


/**
 * Stores the result of a cryptographic operation.
 * Contains a reference fingerprint to associate result with a user
 */
typedef struct ql_crypto_result {
    const char *fp;
    size_t length;
    unsigned char *data;
} ql_crypto_result;


/**
 * The context struct for a crypto session
 *
 * It is initialised with an owner and a target, then
 * configured to a mode. All functions performed on it
 * afterwards can only be done if supported by the mode.
 *
 * @mbedtls_ctx is internally cast to whatever
 *                implementation is required
 */
typedef struct qlcry_session_ctx {
    unsigned short initialised;
    struct ql_user *owner;
    struct ql_user **participants;
    size_t no_p, array_p;
    enum ql_cipher_t mode;

    /* crypto internals */
    void *random;
    void *entropy;
} qlcry_session_ctx;


#endif //QAUL_QLFORMAT_H
