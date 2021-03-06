{-# OPTIONS --universe-polymorphism #-}

module Issue293a where

open import Agda.Primitive
  using (Level; _⊔_) renaming (lzero to zero; lsuc to suc)

------------------------------------------------------------------------

record RawMonoid c ℓ : Set (suc (c ⊔ ℓ)) where
  infixl 7 _∙_
  infix  4 _≈_
  field
    Carrier : Set c
    _≈_     : Carrier → Carrier → Set ℓ
    _∙_     : Carrier → Carrier → Carrier
    ε       : Carrier

module M (rm : RawMonoid zero zero) where

  open RawMonoid rm

  thm : ∀ x → x ∙ ε ≈ x
  thm = {!!}

  -- Previous agda2-goal-and-context:

  -- rm : RawMonoid zero zero
  -- ------------------------
  -- Goal: (x : RawMonoid.Carrier rm) →
  --       RawMonoid._≈_ rm (RawMonoid._∙_ rm x (RawMonoid.ε rm)) x

  -- Current agda2-goal-and-context:

  -- rm : RawMonoid zero zero
  -- ------------------------
  -- Goal: (x : Carrier) → x ∙ ε ≈ x

------------------------------------------------------------------------

record RawMonoid′ : Set₁ where
  infixl 7 _∙_
  infix  4 _≈_
  field
    Carrier : Set
    _≈_     : Carrier → Carrier → Set
    _∙_     : Carrier → Carrier → Carrier
    ε       : Carrier


module M′ (rm : RawMonoid′) where

  open RawMonoid′ rm

  thm′ : ∀ x → x ∙ ε ≈ x
  thm′ = {!!}

  -- Previous and current agda2-goal-and-context:

  -- rm : RawMonoid′
  -- ---------------
  -- Goal: (x : Carrier) → x ∙ ε ≈ x

------------------------------------------------------------------------

-- UP isn't relevant.

record RawMonoid″ (Carrier : Set) : Set₁ where
  infixl 7 _∙_
  infix  4 _≈_
  field
    _≈_     : Carrier → Carrier → Set
    _∙_     : Carrier → Carrier → Carrier
    ε       : Carrier

data Bool : Set where
  true false : Bool

data List (A : Set) : Set where
  []  :                        List A
  _∷_ : (x : A)(xs : List A) → List A

module M″ (rm : RawMonoid″ (List Bool)) where

  open RawMonoid″ rm

  thm″ : ∀ x → x ∙ ε ≈ x
  thm″ = {!!}

  -- Previous agda2-goal-and-context:

  -- rm : RawMonoid″ (List Bool)
  -- ---------------------------
  -- Goal: (x : List Bool) →
  --       RawMonoid″._≈_ rm (RawMonoid″._∙_ rm x (RawMonoid″.ε rm)) x

  -- Current agda2-goal-and-context:

  -- rm : RawMonoid″ (List Bool)
  -- ---------------------------
  -- Goal: (x : List Bool) → x ∙ ε ≈ x
