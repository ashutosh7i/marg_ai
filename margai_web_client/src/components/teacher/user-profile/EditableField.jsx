/* eslint-disable react/prop-types */

import { useState } from "react";
import useClickOutside from "@/hooks/useClickOutside";

function EditableField({ value, onEdit, icon, leftIcon, className = "" }) {
  const [isEditing, setIsEditing] = useState(false);
  const [editValue, setEditValue] = useState(value);
  const ref = useClickOutside(() => handleSubmit());

  const handleSubmit = () => {
    if (isEditing) {
      onEdit(editValue);
      setIsEditing(false);
    }
  };

  const handleKeyDown = (e) => {
    if (e.key === "Enter") {
      handleSubmit();
    }
  };

  if (isEditing) {
    return (
      <div ref={ref} className="flex items-center gap-2">
        {leftIcon && <span>{leftIcon}</span>}
        <input
          type="text"
          value={editValue}
          onChange={(e) => setEditValue(e.target.value)}
          onKeyDown={handleKeyDown}
          className={`w-10/12 rounded-md border border-gray-300 px-2 py-1 focus:outline-none focus:ring-1 focus:ring-black ${className}`}
          autoFocus
        />
      </div>
    );
  }

  return (
    <div
      className="group flex cursor-pointer items-center gap-2"
      onClick={() => setIsEditing(true)}
    >
      {leftIcon && <span>{leftIcon}</span>}
      <span className={className}>{value}</span>
      <span className="opacity-0 transition-opacity group-hover:opacity-100">
        {icon}
      </span>
    </div>
  );
}

export default EditableField;
