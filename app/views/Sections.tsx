import React from "react";
import { useState, useEffect } from 'react';
import Header from "./Header";
import Footer from "./Footer";
import { Link } from "react-router-dom";

export default function Sections() {
  const [sections, setSections] = useState([]);
  useEffect(() => {
    fetch('/api/sections')
      .then(response => response.json())
      .then(data => setSections(data));
  }, [setSections]);
  return (
    <>
      <Header title="All about Rubee" />
      <main>
        <h2 id="why">All about Rubee</h2>
        <div className="features">
          {sections.map(section => (
            <div key={section.id} className="feature">
              <Link to={`/sections/${section.id}/documents`}>
                <h3>{section.title}</h3>
              </Link>
              <p dangerouslySetInnerHTML={{ __html: section.description.slice(0, 60) + " ..." }} />
            </div>
          ))}
        </div>
      </main>
      <Footer />
    </>
  );
}
