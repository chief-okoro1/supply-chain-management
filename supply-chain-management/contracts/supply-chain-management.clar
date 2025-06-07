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

;; Verification Mechanism Mapping
(define-map product-verifications
  uint
  {
    verified-parties: (list 10 principal),
    verification-threshold: uint,
    is-verified: bool,
  }
)

;; Transportation Log Mapping
(define-map transportation-logs
  uint
  (list 20 {
    carrier: principal,
    timestamp: uint,
    location: (string-ascii 100),
    status: uint
  })
)

;; Read-only Functions for Retrieving Product Information
(define-read-only (get-product-details (product-id uint))
  (map-get? product-provenance product-id)
)

(define-read-only (get-transportation-logs (product-id uint))
  (map-get? transportation-logs product-id)
)

(define-read-only (get-product-verification-status (product-id uint))
  (map-get? product-verifications product-id)
)

;; Mapping for Product Ownership
(define-map product-ownership
  uint  ;; product-id
  principal  ;; current owner
)

;; Read-only Function
(define-read-only (get-product-owner (product-id uint))
  (map-get? product-ownership product-id)
)

;; Mapping for Product Certifications
(define-map product-certifications
  uint
  {
    certifications: (list 10 (string-ascii 100)),
    compliance-docs: (list 5 (string-ascii 100))
  }
)

;; Read-only Function
(define-read-only (get-product-certifications (product-id uint))
  (map-get? product-certifications product-id)
)

;; Contract-level Pause Variable
(define-data-var contract-paused bool false)

;; Pausable Trait
(define-trait pausable-trait
  ((is-paused () (response bool uint)))
)

;; Audit Log Entry Structure
(define-map audit-logs
  uint  ;; product-id
  {
    events: (list 50 {
      event-type: (string-ascii 50),
      timestamp: uint,
      actor: principal,
      details: (string-ascii 200)
    })
  }
)

;; Multi-Signature Approval Mapping
(define-map multi-sig-approvals
  {
    product-id: uint,
    approval-type: (string-ascii 50)
  }
  {
    required-signatures: uint,
    current-signatures: (list 10 principal),
    is-approved: bool
  }
)
