import React from "react";
import { BrowserRouter as Router, Routes, Route, Link } from "react-router-dom";
import "./../../css/app.css";
import Main from "./Main";
import Sections from "./Sections";
import Document from "./Document";
import Documents from "./Documents";

const NotFound = () => <h2>404 Not Found</h2>;

export function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Main />} />
        <Route path="/docs" element={<Sections />} />
        <Route path="*" element={<NotFound />} />
        <Route path="/documents/:id" element={<Document />} />
        <Route path="/sections/:id/documents" element={<Documents />} />
      </Routes>
    </Router>
  );
}

