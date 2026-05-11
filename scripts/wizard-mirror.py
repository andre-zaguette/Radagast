#!/usr/bin/env python3
import sys

# Mirror of Galadriel (Radagast): Python Quality Self-Audit
RUBRIC = {
    "1. Contract Defined": "Input/output shapes definidos com Pydantic/dataclass antes de implementar?",
    "2. Proof Before Alloy": "Testes pytest escritos e passando antes da implementação?",
    "3. Type Discipline": "Zero `Any`. Zero dicts não tipados. Todas as fronteiras têm modelo?",
    "4. Pure Functions": "Funções são puras onde possível? Side effects isolados nas bordas?",
    "5. Mithril Armor": "Scan executado: sem secrets hardcoded, sem eval/exec, sem SQL injection?"
}

def self_audit():
    print("✨ Mirror of Galadriel (Radagast): Reflecting upon your Python work...")
    score = 0
    total = len(RUBRIC)

    for key, desc in RUBRIC.items():
        print(f"\n[ ] {key}: {desc}")
        val = input("Grade (1-5): ")
        try:
            score += int(val)
        except:
            pass

    final_score = (score / (total * 5)) * 100
    print(f"\n📊 Final Alignment: {final_score:.1f}%")

    if final_score < 80:
        print("⚠️ The Mirror shows shadows. Strengthen contracts and tests before signaling Boromir.")
        sys.exit(1)
    else:
        print("✅ The work is pure. Signal Boromir with artifacts and contracts.")
        sys.exit(0)

if __name__ == "__main__":
    self_audit()
