//==============================================================
// Copyright © 2020 Intel Corporation
//
// SPDX-License-Identifier: MIT
// =============================================================

#include <iostream>
#include <vector>
using namespace std;
class Complex2 {
 private:
  mutable int m_real_, m_imag_;

 public:
    void setReal (int c) const { m_real_ = c; }
    void setImag (int c) const { m_imag_ = c; }
    
  Complex2() {
    setReal(0);
    setImag(0);
  }
  Complex2(int x, int y) {
    setReal(x);
    setImag(y);
  }
    
  int getReal() const {
      return m_real_;
  }
    
  int getImag() const {
      return m_imag_;
  }

  // Overloading the  != operator
  friend bool operator!=(const Complex2& a, const Complex2& b) {
    return (a.m_real_ != b.m_real_) || (a.m_imag_ != b.m_imag_);
  }

  // The function performs Complex number multiplication and returns a Complex2
  // object.
  Complex2 complex_mul(const Complex2& obj) const {
    return Complex2(((this->getReal() * obj.getReal()) - (this->getImag() * obj.getImag())),
                    ((this->getReal() * obj.getImag()) + (this->getImag() * obj.getReal())));
      /*return Complex2(((m_real_ * obj.m_real_) - (m_imag_ * obj.m_imag_)),
                    ((m_real_ * obj.m_imag_) + (m_imag_ * obj.m_real_)));*/
  }

  // Overloading the ostream operator to print the objects of the Complex2
  // object
  friend ostream& operator<<(ostream& out, const Complex2& obj) {
    out << "(" << obj.m_real_ << " : " << obj.m_imag_ << "i)";
    return out;
  }
};