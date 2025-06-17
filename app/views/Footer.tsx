import React from "react";

export default function Footer() {
  const year = new Date().getFullYear();

  return (
    <footer>
      &copy; {year} Rubee — Made with 💜
    </footer>
  );
}
