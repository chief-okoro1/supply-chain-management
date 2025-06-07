;; title: supply-chain-management
;; Constants and Error Definitions
(define-constant CONTRACT-OWNER tx-sender)
(define-constant ERR-UNAUTHORIZED (err u1))
(define-constant ERR-INVALID-PRODUCT (err u2))
(define-constant ERR-VERIFICATION-FAILED (err u3))
;; Constant Definitions
(define-constant MAX-PARTICIPANTS u50)
(define-constant MAX-CERTIFICATIONS u10)
(define-constant MAX-COMPLIANCE-DOCS u5)

;; Product Status Enum
(define-constant PRODUCT-STATUS-CREATED u1)
(define-constant PRODUCT-STATUS-IN-TRANSIT u2)
(define-constant PRODUCT-STATUS-DELIVERED u3)
(define-constant PRODUCT-STATUS-VERIFIED u4)

;; Additional Error Constants
(define-constant ERR-ALREADY-EXISTS (err u4))
(define-constant ERR-NOT-FOUND (err u5))

;; Product Provenance Mapping
(define-map product-provenance
  uint
  {
    product-name: (string-ascii 100),
    manufacturer: principal,
    origin-location: (string-ascii 100),
    creation-timestamp: uint,
    current-status: uint,
    current-location: (string-ascii 100),
    raw-materials: (list 10 {
      material-name: (string-ascii 50),
      material-source: (string-ascii 100)
    })
  }
)