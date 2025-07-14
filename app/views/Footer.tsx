
import React from "react";

export default function Footer() {
  const year = new Date().getFullYear();

  return (
    <footer>
      <div>&copy; {year} Rubee</div>
      <div className="pi-hosting">
        <span>Hosted on Raspberry Pi </span>
        <img
          src="/images/pi_logo.png"
          alt="Raspberry Pi Logo"
          className="pi-logo"
          height="25"
        />
      </div>
    </footer>
  );
}

