/**
 * Chenab Hostel Management System - Frontend Controller
 * Connects to the Express & MySQL Backend with the complete 5-Step Allotment Workflow.
 */

const API_BASE = window.location.origin;

// State Store
let state = {
    currentRole: 'WARDEN',
    rooms: [],
    students: [],
    allocations: [],
    allotmentRules: [],
    applications: [],
    swaps: [],
    attendance: [],
    complaints: [],
    fees: [],
    staff: []
};

// Initialization on DOM Load
document.addEventListener('DOMContentLoaded', async () => {
    lucide.createIcons();
    setupRoleSelector();
    await checkApiHealth();
    await loadInitialData();
});

// Setup Role Simulator
function setupRoleSelector() {
    const selector = document.getElementById('role-selector');
    if (selector) {
        selector.addEventListener('change', (e) => {
            state.currentRole = e.target.value;
            showNotification(`Switched role to ${state.currentRole}`, 'info');
        });
    }
}

// Check Backend Connection
async function checkApiHealth() {
    const statusText = document.getElementById('api-status-text');
    try {
        const res = await fetch(`${API_BASE}/api/health`);
        if (res.ok) {
            statusText.textContent = 'Backend & DB Online';
        } else {
            statusText.textContent = 'API Reconnecting...';
        }
    } catch (e) {
        statusText.textContent = 'Demo / Local Mode';
    }
}

// Load Core Data from Backend
async function loadInitialData() {
    try {
        await Promise.all([
            fetchRooms(),
            fetchStudents(),
            fetchAllocations(),
            fetchAllotmentRules(),
            fetchAllotmentApplications(),
            fetchSwaps(),
            fetchAttendance(),
            fetchComplaints(),
            fetchFees(),
            fetchStaff()
        ]);
        renderDashboard();
        renderRoomsGrid();
        renderStudentsTable();
        renderRulesList();
        renderVerificationQueue();
        renderRankingTable();
        renderAllocationFeed();
        renderSwapsTable();
        populateDropdowns();
        lucide.createIcons();
    } catch (err) {
        console.error('Error loading data:', err);
    }
}

// -------------------------------------------------------------
// Data Fetching Functions
// -------------------------------------------------------------
async function fetchRooms() {
    const res = await fetch(`${API_BASE}/api/rooms`);
    state.rooms = await res.json();
}

async function fetchStudents() {
    const res = await fetch(`${API_BASE}/api/students`);
    state.students = await res.json();
}

async function fetchAllocations() {
    const res = await fetch(`${API_BASE}/api/allocations`);
    state.allocations = await res.json();
}

async function fetchAllotmentRules() {
    const res = await fetch(`${API_BASE}/api/allotments/rules`);
    const data = await res.json();
    state.allotmentRules = data.rules || [];
}

async function fetchAllotmentApplications() {
    const res = await fetch(`${API_BASE}/api/allotments/applications`);
    const data = await res.json();
    state.applications = data.applications || [];
}

async function fetchSwaps() {
    const res = await fetch(`${API_BASE}/api/allotments/swaps`);
    const data = await res.json();
    state.swaps = data.swaps || [];
}

async function fetchAttendance() {
    const res = await fetch(`${API_BASE}/api/attendance`);
    state.attendance = await res.json();
}

async function fetchComplaints() {
    const res = await fetch(`${API_BASE}/api/complaints`);
    state.complaints = await res.json();
    renderComplaints();
}

async function fetchFees() {
    const res = await fetch(`${API_BASE}/api/fees`);
    state.fees = await res.json();
    renderFees();
}

async function fetchStaff() {
    const res = await fetch(`${API_BASE}/api/staff`);
    state.staff = await res.json();
    renderStaff();
}

// -------------------------------------------------------------
// TAB NAVIGATION
// -------------------------------------------------------------
function switchTab(tabId) {
    const tabs = ['allotment', 'dashboard', 'rooms', 'students', 'attendance', 'complaints', 'fees', 'staff'];
    tabs.forEach(t => {
        const btn = document.getElementById(`tab-${t}`);
        const view = document.getElementById(`view-${t}`);
        if (btn) btn.classList.remove('active', 'text-blue-600', 'border-blue-600');
        if (view) view.classList.add('hidden');
    });

    const activeBtn = document.getElementById(`tab-${tabId}`);
    const activeView = document.getElementById(`view-${tabId}`);
    if (activeBtn) activeBtn.classList.add('active', 'text-blue-600', 'border-blue-600');
    if (activeView) activeView.classList.remove('hidden');

    lucide.createIcons();
}

// -------------------------------------------------------------
// 5-STEP ALLOTMENT WORKFLOW STAGES
// -------------------------------------------------------------
function selectWorkflowStep(stepNumber) {
    for (let i = 1; i <= 5; i++) {
        const card = document.getElementById(`step-card-${i}`);
        const pane = document.getElementById(`stage-pane-${i}`);
        if (card) {
            if (i === stepNumber) {
                card.classList.add('border-2', 'border-blue-600', 'bg-blue-50/50');
                card.classList.remove('border-slate-200', 'bg-white');
            } else {
                card.classList.remove('border-2', 'border-blue-600', 'bg-blue-50/50');
                card.classList.add('border', 'border-slate-200', 'bg-white');
            }
        }
        if (pane) {
            pane.classList.toggle('hidden', i !== stepNumber);
        }
    }
    lucide.createIcons();
}

// STAGE 1: Submit Application
async function handleApply(e) {
    e.preventDefault();
    const studentId = document.getElementById('apply-student-id').value;
    const yearOfStudy = document.getElementById('apply-year').value;
    const cgpa = document.getElementById('apply-cgpa').value;
    const roomType = document.getElementById('apply-room-type').value;
    const floor = document.getElementById('apply-floor').value;
    const roommate = document.getElementById('apply-roommate').value;
    const notes = document.getElementById('apply-notes').value;

    try {
        const res = await fetch(`${API_BASE}/api/allotments/apply`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                student_id: studentId,
                year_of_study: yearOfStudy,
                cgpa: cgpa,
                preferred_room_type: roomType,
                preferred_floor: floor,
                preferred_roommate_enrolment: roommate,
                special_requirements: notes
            })
        });
        const data = await res.json();
        if (data.success) {
            showNotification('Application submitted successfully! Moved to Step 2 Verification.', 'success');
            await fetchAllotmentApplications();
            renderVerificationQueue();
            selectWorkflowStep(2);
        } else {
            showNotification(data.error || 'Failed to submit application', 'error');
        }
    } catch (err) {
        showNotification('Submission error: ' + err.message, 'error');
    }
}

// STAGE 2: Verification Queue
function renderVerificationQueue() {
    const tbody = document.getElementById('verification-table-body');
    if (!tbody) return;

    if (state.applications.length === 0) {
        tbody.innerHTML = `<tr><td colspan="5" class="py-4 text-center text-slate-400">No applications currently in queue.</td></tr>`;
        return;
    }

    tbody.innerHTML = state.applications.map(app => {
        const isVerified = app.verification_status === 'VERIFIED';
        const isRejected = app.verification_status === 'REJECTED';
        const badgeColor = isVerified ? 'bg-emerald-100 text-emerald-800' : (isRejected ? 'bg-rose-100 text-rose-800' : 'bg-amber-100 text-amber-800');

        return `
            <tr class="hover:bg-slate-50 transition">
                <td class="py-2.5 px-3">
                    <div class="font-bold text-slate-900">${app.student_name}</div>
                    <div class="text-2xs text-slate-500">${app.enrolment_no} (${app.branch})</div>
                </td>
                <td class="py-2.5 px-3">
                    <span class="font-semibold text-slate-800">Year ${app.year_of_study || 1}</span>
                    <div class="text-2xs text-slate-500">CGPA: ${app.cgpa || 7.5} / 10</div>
                </td>
                <td class="py-2.5 px-3">
                    <span class="px-2 py-0.5 rounded bg-slate-100 text-slate-700 text-2xs font-semibold">${app.preferred_room_type}</span>
                    <div class="text-2xs text-slate-500 mt-0.5">Floor ${app.preferred_floor || 1}</div>
                </td>
                <td class="py-2.5 px-3">
                    <span class="px-2 py-0.5 rounded-full text-2xs font-bold ${badgeColor}">
                        ${app.verification_status}
                    </span>
                    ${app.verification_notes ? `<div class="text-2xs text-slate-400 mt-0.5">${app.verification_notes}</div>` : ''}
                </td>
                <td class="py-2.5 px-3 text-right">
                    ${!isVerified ? `
                        <button onclick="handleVerify(${app.application_id}, 'VERIFIED')" class="px-2.5 py-1 bg-emerald-600 hover:bg-emerald-700 text-white rounded-md text-2xs font-semibold mr-1 shadow-sm">
                            Verify ERP
                        </button>
                        <button onclick="handleVerify(${app.application_id}, 'REJECTED')" class="px-2 py-1 bg-slate-200 hover:bg-rose-100 hover:text-rose-700 text-slate-600 rounded-md text-2xs font-semibold">
                            Reject
                        </button>
                    ` : `
                        <span class="text-2xs text-emerald-600 font-semibold flex items-center justify-end gap-1">
                            <i data-lucide="check-circle" class="w-3.5 h-3.5"></i> Verified
                        </span>
                    `}
                </td>
            </tr>
        `;
    }).join('');
    lucide.createIcons();
}

async function handleVerify(appId, status) {
    try {
        const res = await fetch(`${API_BASE}/api/allotments/verify/${appId}`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ verification_status: status })
        });
        const data = await res.json();
        if (data.success) {
            showNotification(`Application ${status.toLowerCase()} with College ERP`, 'success');
            await fetchAllotmentApplications();
            renderVerificationQueue();
        }
    } catch (err) {
        showNotification('Verification error: ' + err.message, 'error');
    }
}

// STAGE 3: Priority Ranking Engine
function renderRankingTable() {
    const tbody = document.getElementById('ranking-table-body');
    if (!tbody) return;

    const ranked = state.applications
        .filter(a => a.calculated_score > 0)
        .sort((a, b) => b.calculated_score - a.calculated_score);

    if (ranked.length === 0) {
        tbody.innerHTML = `<tr><td colspan="5" class="py-4 text-center text-slate-400">Click "Run Ranking Algorithm" to evaluate priority list.</td></tr>`;
        return;
    }

    tbody.innerHTML = ranked.map((app, index) => {
        const rank = index + 1;
        const rankBadge = rank === 1 ? 'bg-amber-100 text-amber-800 border-amber-300' :
                         (rank === 2 ? 'bg-slate-200 text-slate-700 border-slate-300' :
                         (rank === 3 ? 'bg-amber-50 text-amber-900 border-amber-200' : 'bg-slate-50 text-slate-600 border-slate-200'));

        return `
            <tr class="hover:bg-slate-50 transition">
                <td class="py-2.5 px-3">
                    <span class="inline-flex items-center justify-center w-6 h-6 rounded-full text-xs font-bold border ${rankBadge}">
                        ${rank}
                    </span>
                </td>
                <td class="py-2.5 px-3">
                    <div class="font-bold text-slate-900">${app.student_name}</div>
                    <div class="text-2xs text-slate-500">${app.enrolment_no}</div>
                </td>
                <td class="py-2.5 px-3">
                    <span class="text-slate-800 font-semibold">Year ${app.year_of_study}</span>
                    <span class="text-2xs text-slate-500 ml-1">(CGPA: ${app.cgpa})</span>
                </td>
                <td class="py-2.5 px-3">
                    <div class="font-bold text-blue-700 text-sm">${app.calculated_score} pts</div>
                </td>
                <td class="py-2.5 px-3">
                    <span class="px-2 py-0.5 rounded-full text-2xs font-semibold ${app.application_status === 'ALLOCATED' ? 'bg-emerald-100 text-emerald-800' : 'bg-blue-100 text-blue-800'}">
                        ${app.application_status}
                    </span>
                </td>
            </tr>
        `;
    }).join('');
    lucide.createIcons();
}

async function computeLiveRanking() {
    try {
        const res = await fetch(`${API_BASE}/api/allotments/rank`, { method: 'POST' });
        const data = await res.json();
        if (data.success) {
            showNotification(data.message, 'success');
            await fetchAllotmentApplications();
            renderRankingTable();
            selectWorkflowStep(3);
        } else {
            showNotification('Error ranking: ' + data.error, 'error');
        }
    } catch (err) {
        showNotification('Ranking computation failed: ' + err.message, 'error');
    }
}

// STAGE 4: Room Allocation & Space Matching
function renderAllocationFeed() {
    const feed = document.getElementById('allocation-feed');
    if (!feed) return;

    const activeAllocations = state.allocations.filter(a => a.allocation_status === 'ACTIVE');

    if (activeAllocations.length === 0) {
        feed.innerHTML = `<div class="p-6 text-center text-slate-400 border border-dashed rounded-xl">No active room allocations found.</div>`;
        return;
    }

    feed.innerHTML = activeAllocations.slice(0, 10).map(al => {
        return `
            <div class="p-3.5 bg-slate-50 border border-slate-200 rounded-xl flex items-center justify-between hover:border-blue-300 transition">
                <div class="flex items-center gap-3">
                    <div class="w-9 h-9 rounded-lg bg-blue-100 text-blue-800 font-bold flex items-center justify-center text-xs">
                        ${al.room_number || 'Room'}
                    </div>
                    <div>
                        <div class="font-bold text-slate-900 text-xs">${al.full_name}</div>
                        <div class="text-2xs text-slate-500">${al.enrolment_no} • Allocated on ${al.allocation_date}</div>
                    </div>
                </div>
                <div class="flex items-center gap-2">
                    <span class="px-2 py-0.5 rounded-md bg-emerald-100 text-emerald-800 font-bold text-2xs">ACTIVE</span>
                    <button onclick="handleVacateDirect(${al.allocation_id})" class="px-2 py-1 bg-white hover:bg-rose-50 text-rose-600 border border-slate-200 rounded text-2xs font-semibold">
                        Vacate
                    </button>
                </div>
            </div>
        `;
    }).join('');
    lucide.createIcons();
}

async function triggerAutoAllocation() {
    try {
        const res = await fetch(`${API_BASE}/api/allotments/allocate-batch`, { method: 'POST' });
        const data = await res.json();
        if (data.success) {
            showNotification(data.message, 'success');
            await Promise.all([fetchAllocations(), fetchRooms(), fetchAllotmentApplications()]);
            renderAllocationFeed();
            renderRoomsGrid();
            renderDashboard();
            selectWorkflowStep(4);
        } else {
            showNotification(data.error || 'Allocation error', 'error');
        }
    } catch (err) {
        showNotification('Allocation failed: ' + err.message, 'error');
    }
}

// STAGE 5: Swaps & Vacancies Table
function renderSwapsTable() {
    const tbody = document.getElementById('swaps-table-body');
    if (!tbody) return;

    if (state.swaps.length === 0) {
        tbody.innerHTML = `<tr><td colspan="5" class="py-4 text-center text-slate-400">No active swap requests.</td></tr>`;
        return;
    }

    tbody.innerHTML = state.swaps.map(sw => {
        const isApproved = sw.warden_status === 'APPROVED';
        const isRejected = sw.warden_status === 'REJECTED';
        const statusBadge = isApproved ? 'bg-emerald-100 text-emerald-800' : (isRejected ? 'bg-rose-100 text-rose-800' : 'bg-amber-100 text-amber-800');

        return `
            <tr class="hover:bg-slate-50 transition">
                <td class="py-2.5 px-3">
                    <div class="font-bold text-slate-900">${sw.requester_name}</div>
                    <div class="text-2xs text-blue-600 font-semibold">Room: ${sw.requester_room_no}</div>
                </td>
                <td class="py-2.5 px-3">
                    <div class="font-bold text-slate-900">${sw.target_name}</div>
                    <div class="text-2xs text-indigo-600 font-semibold">Room: ${sw.target_room_no}</div>
                </td>
                <td class="py-2.5 px-3">
                    <span class="text-slate-600 text-xs">${sw.reason}</span>
                </td>
                <td class="py-2.5 px-3">
                    <span class="px-2 py-0.5 rounded-full text-2xs font-bold ${statusBadge}">
                        ${sw.warden_status}
                    </span>
                </td>
                <td class="py-2.5 px-3 text-right">
                    ${sw.warden_status === 'PENDING' ? `
                        <button onclick="handleApproveSwap(${sw.swap_id}, 'APPROVED')" class="px-2.5 py-1 bg-emerald-600 hover:bg-emerald-700 text-white rounded text-2xs font-semibold mr-1 shadow-sm">
                            Approve Swap
                        </button>
                        <button onclick="handleApproveSwap(${sw.swap_id}, 'REJECTED')" class="px-2 py-1 bg-slate-200 hover:bg-rose-100 hover:text-rose-700 text-slate-700 rounded text-2xs font-semibold">
                            Reject
                        </button>
                    ` : `
                        <span class="text-2xs text-slate-400">Resolved</span>
                    `}
                </td>
            </tr>
        `;
    }).join('');
    lucide.createIcons();
}

async function handleApproveSwap(swapId, status) {
    try {
        const res = await fetch(`${API_BASE}/api/allotments/swaps/${swapId}/approve`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ status })
        });
        const data = await res.json();
        if (data.success) {
            showNotification(data.message, 'success');
            await Promise.all([fetchSwaps(), fetchAllocations(), fetchRooms()]);
            renderSwapsTable();
            renderAllocationFeed();
            renderRoomsGrid();
        }
    } catch (err) {
        showNotification('Swap approval error: ' + err.message, 'error');
    }
}

async function handleVacateStudent() {
    const studentId = document.getElementById('vacate-student-select').value;
    if (!studentId) return;

    try {
        const res = await fetch(`${API_BASE}/api/allotments/vacate`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ student_id: studentId })
        });
        const data = await res.json();
        if (data.success) {
            showNotification(data.message, 'success');
            await Promise.all([fetchAllocations(), fetchRooms()]);
            renderAllocationFeed();
            renderRoomsGrid();
            renderDashboard();
            populateDropdowns();
        }
    } catch (err) {
        showNotification('Error vacating student: ' + err.message, 'error');
    }
}

async function handleVacateDirect(allocationId) {
    try {
        const res = await fetch(`${API_BASE}/api/allotments/vacate`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ allocation_id: allocationId })
        });
        const data = await res.json();
        if (data.success) {
            showNotification(data.message, 'success');
            await Promise.all([fetchAllocations(), fetchRooms()]);
            renderAllocationFeed();
            renderRoomsGrid();
            renderDashboard();
        }
    } catch (err) {
        showNotification('Error vacating: ' + err.message, 'error');
    }
}

// -------------------------------------------------------------
// DYNAMIC RULES INSPECTOR & WEIGHT ADJUSTER
// -------------------------------------------------------------
function renderRulesList() {
    const container = document.getElementById('rules-list');
    if (!container) return;

    container.innerHTML = state.allotmentRules.map(rule => {
        return `
            <div class="p-3 bg-slate-50 border border-slate-200 rounded-xl space-y-2">
                <div class="flex items-center justify-between">
                    <span class="font-bold text-slate-800 text-xs">${rule.rule_name}</span>
                    <span class="text-2xs font-semibold text-blue-600 bg-blue-50 px-2 py-0.5 rounded border border-blue-200">
                        ${rule.criteria_type}
                    </span>
                </div>
                <div class="flex items-center justify-between gap-3 text-xs">
                    <span class="text-slate-500 text-2xs">Weight:</span>
                    <div class="flex items-center gap-1.5 flex-1">
                        <input type="range" min="5" max="60" value="${rule.weight}" 
                               onchange="updateRuleWeight(${rule.rule_id}, this.value)"
                               class="w-full accent-blue-600 h-1.5 bg-slate-200 rounded-lg cursor-pointer">
                        <span class="font-bold text-slate-800 text-xs w-8 text-right">${rule.weight}%</span>
                    </div>
                </div>
                <p class="text-2xs text-slate-400">${rule.description || ''}</p>
            </div>
        `;
    }).join('');
}

async function updateRuleWeight(ruleId, newWeight) {
    try {
        const res = await fetch(`${API_BASE}/api/allotments/rules/${ruleId}`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ weight: newWeight })
        });
        const data = await res.json();
        if (data.success) {
            showNotification(`Updated rule weight to ${newWeight}% in table`, 'info');
            await fetchAllotmentRules();
            renderRulesList();
        }
    } catch (err) {
        console.error('Error updating rule:', err);
    }
}

// -------------------------------------------------------------
// DASHBOARD & ROOMS GRID
// -------------------------------------------------------------
function renderDashboard() {
    const totalRooms = state.rooms.length;
    const totalBeds = state.rooms.reduce((acc, r) => acc + r.capacity, 0);
    const activeAllocations = state.allocations.filter(a => a.allocation_status === 'ACTIVE').length;
    const occupancyRate = totalBeds > 0 ? Math.round((activeAllocations / totalBeds) * 100) : 0;

    const dashRooms = document.getElementById('dash-rooms');
    const dashOccupancy = document.getElementById('dash-occupancy');
    const dashOccupancySub = document.getElementById('dash-occupancy-sub');
    const dashComplaints = document.getElementById('dash-complaints');
    const dashFees = document.getElementById('dash-fees');

    if (dashRooms) dashRooms.textContent = `${totalRooms} Rooms`;
    if (dashOccupancy) dashOccupancy.textContent = `${occupancyRate}%`;
    if (dashOccupancySub) dashOccupancySub.textContent = `${activeAllocations} of ${totalBeds} beds assigned`;

    const openComplaints = state.complaints.filter(c => c.complaint_status !== 'RESOLVED').length;
    if (dashComplaints) dashComplaints.textContent = `${openComplaints} Open`;

    const totalBalance = state.fees.reduce((acc, f) => acc + (parseFloat(f.balance) || 0), 0);
    if (dashFees) dashFees.textContent = `₹${totalBalance.toLocaleString('en-IN')}`;

    // Pipeline stat cards
    const statApps = document.getElementById('stat-apps-count');
    const statVerified = document.getElementById('stat-verified-count');
    const statAllocated = document.getElementById('stat-allocated-count');
    const statVacant = document.getElementById('stat-vacant-beds');

    if (statApps) statApps.textContent = state.applications.length;
    if (statVerified) statVerified.textContent = state.applications.filter(a => a.verification_status === 'VERIFIED').length;
    if (statAllocated) statAllocated.textContent = activeAllocations;
    if (statVacant) statVacant.textContent = totalBeds - activeAllocations;

    // Floor summary
    const floorContainer = document.getElementById('floor-summary');
    if (floorContainer) {
        floorContainer.innerHTML = [1, 2, 3, 4].map(floorNum => {
            const floorRooms = state.rooms.filter(r => r.floor_number === floorNum);
            const floorCapacity = floorRooms.reduce((acc, r) => acc + r.capacity, 0);
            const floorOccupied = state.allocations.filter(a => {
                const room = state.rooms.find(r => r.room_id === a.room_id);
                return room && room.floor_number === floorNum && a.allocation_status === 'ACTIVE';
            }).length;

            return `
                <div class="bg-slate-50 border border-slate-200 rounded-xl p-4">
                    <div class="flex items-center justify-between mb-2">
                        <span class="font-bold text-slate-800 text-xs">Floor ${floorNum}</span>
                        <span class="text-2xs font-semibold px-2 py-0.5 rounded ${floorOccupied >= floorCapacity ? 'bg-rose-100 text-rose-700' : 'bg-emerald-100 text-emerald-700'}">
                            ${floorCapacity - floorOccupied} vacant
                        </span>
                    </div>
                    <div class="text-xl font-bold text-slate-900">${floorOccupied} / ${floorCapacity}</div>
                    <div class="w-full bg-slate-200 rounded-full h-1.5 mt-2">
                        <div class="bg-blue-600 h-1.5 rounded-full" style="width: ${floorCapacity > 0 ? (floorOccupied / floorCapacity) * 100 : 0}%"></div>
                    </div>
                </div>
            `;
        }).join('');
    }
}

function renderRoomsGrid() {
    const grid = document.getElementById('rooms-grid');
    if (!grid) return;

    const floorFilter = document.getElementById('room-floor-filter')?.value || 'ALL';
    const filteredRooms = state.rooms.filter(r => floorFilter === 'ALL' || r.floor_number === parseInt(floorFilter));

    grid.innerHTML = filteredRooms.map(room => {
        const roomAllocs = state.allocations.filter(a => a.room_id === room.room_id && a.allocation_status === 'ACTIVE');
        const occupied = roomAllocs.length;
        const isFull = occupied >= room.capacity;

        return `
            <div class="bg-white border ${isFull ? 'border-slate-200' : 'border-blue-200 shadow-sm'} rounded-2xl p-4 transition-all hover:shadow-md">
                <div class="flex items-center justify-between mb-2">
                    <span class="text-base font-bold text-slate-900">${room.room_number}</span>
                    <span class="px-2 py-0.5 text-2xs font-bold rounded ${room.room_type === 'DELUXE' ? 'bg-amber-100 text-amber-800' : 'bg-slate-100 text-slate-600'}">
                        ${room.room_type}
                    </span>
                </div>
                <div class="flex items-center justify-between text-xs text-slate-500 mb-3">
                    <span>Floor ${room.floor_number}</span>
                    <span class="font-semibold text-slate-700">₹${room.monthly_fee}/mo</span>
                </div>

                <!-- Beds Capacity Progress -->
                <div class="space-y-1 mb-3">
                    <div class="flex items-center justify-between text-2xs font-semibold">
                        <span class="${isFull ? 'text-rose-600' : 'text-emerald-600'}">${occupied} of ${room.capacity} Beds Occupied</span>
                        <span class="text-slate-400">${room.capacity - occupied} Vacant</span>
                    </div>
                    <div class="w-full bg-slate-100 rounded-full h-1.5 overflow-hidden">
                        <div class="h-1.5 rounded-full ${isFull ? 'bg-rose-500' : 'bg-emerald-500'}" style="width: ${(occupied / room.capacity) * 100}%"></div>
                    </div>
                </div>

                <!-- Occupants avatars/pills -->
                <div class="space-y-1 pt-2 border-t border-slate-100">
                    ${roomAllocs.length > 0 ? roomAllocs.map(a => `
                        <div class="text-2xs text-slate-600 truncate flex items-center gap-1.5">
                            <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span>
                            <span class="font-medium">${a.full_name}</span>
                        </div>
                    `).join('') : '<div class="text-2xs text-slate-400 italic">No occupants currently assigned</div>'}
                </div>
            </div>
        `;
    }).join('');
    lucide.createIcons();
}

function filterRooms() {
    renderRoomsGrid();
}

// -------------------------------------------------------------
// STUDENTS DIRECTORY
// -------------------------------------------------------------
function renderStudentsTable() {
    const tbody = document.getElementById('students-table-body');
    if (!tbody) return;

    const search = document.getElementById('student-search-input')?.value.toLowerCase() || '';
    const branch = document.getElementById('student-branch-filter')?.value || 'ALL';

    const filtered = state.students.filter(s => {
        const matchSearch = s.full_name.toLowerCase().includes(search) || s.enrolment_no.toLowerCase().includes(search);
        const matchBranch = branch === 'ALL' || s.branch === branch;
        return matchSearch && matchBranch;
    });

    tbody.innerHTML = filtered.map(s => {
        const alloc = state.allocations.find(a => a.student_id === s.student_id && a.allocation_status === 'ACTIVE');
        const room = alloc ? state.rooms.find(r => r.room_id === alloc.room_id) : null;

        return `
            <tr class="hover:bg-slate-50 transition">
                <td class="py-3 px-4 font-bold text-slate-900">${s.enrolment_no}</td>
                <td class="py-3 px-4">${s.full_name}</td>
                <td class="py-3 px-4">
                    <span class="px-2 py-0.5 rounded bg-blue-50 text-blue-700 font-semibold text-2xs">${s.branch}</span>
                </td>
                <td class="py-3 px-4">
                    ${room ? `
                        <span class="font-bold text-slate-800">${room.room_number}</span>
                        <span class="text-2xs text-slate-400 ml-1">(Floor ${room.floor_number})</span>
                    ` : '<span class="text-slate-400 italic">Not Allocated</span>'}
                </td>
                <td class="py-3 px-4 text-slate-500">${s.phone || 'N/A'}</td>
                <td class="py-3 px-4">
                    <span class="px-2 py-0.5 rounded-full text-2xs font-bold bg-emerald-100 text-emerald-800">${s.student_status}</span>
                </td>
            </tr>
        `;
    }).join('');
    lucide.createIcons();
}

function filterStudents() {
    renderStudentsTable();
}

// -------------------------------------------------------------
// COMPLAINTS & MAINTENANCE
// -------------------------------------------------------------
function renderComplaints() {
    const grid = document.getElementById('complaints-grid');
    if (!grid) return;

    grid.innerHTML = state.complaints.map(c => {
        const isResolved = c.complaint_status === 'RESOLVED';
        const badgeColor = isResolved ? 'bg-emerald-100 text-emerald-800' : (c.complaint_status === 'IN_PROGRESS' ? 'bg-blue-100 text-blue-800' : 'bg-amber-100 text-amber-800');

        return `
            <div class="bg-white border border-slate-200 rounded-2xl p-4 shadow-sm space-y-3">
                <div class="flex items-center justify-between">
                    <span class="px-2 py-0.5 bg-slate-100 text-slate-700 rounded text-2xs font-bold">${c.complaint_category}</span>
                    <span class="px-2 py-0.5 rounded-full text-2xs font-bold ${badgeColor}">${c.complaint_status}</span>
                </div>
                <div>
                    <h4 class="font-bold text-slate-900 text-sm">${c.complaint_title}</h4>
                    <p class="text-xs text-slate-500 mt-1">${c.description}</p>
                </div>
                <div class="pt-2 border-t border-slate-100 flex items-center justify-between text-2xs text-slate-400">
                    <span>By: ${c.full_name || 'Student'}</span>
                    <span>Staff: ${c.assigned_staff_name || 'Assigned'}</span>
                </div>
            </div>
        `;
    }).join('');
    lucide.createIcons();
}

// -------------------------------------------------------------
// FEES & PAYMENTS
// -------------------------------------------------------------
function renderFees() {
    const tbody = document.getElementById('fees-table-body');
    if (!tbody) return;

    tbody.innerHTML = state.fees.map(f => {
        const isPaid = f.fee_status === 'PAID';
        const badgeColor = isPaid ? 'bg-emerald-100 text-emerald-800' : (f.fee_status === 'PARTIAL' ? 'bg-amber-100 text-amber-800' : 'bg-rose-100 text-rose-800');

        return `
            <tr class="hover:bg-slate-50 transition">
                <td class="py-3 px-4 font-bold text-slate-900">${f.full_name}</td>
                <td class="py-3 px-4 text-slate-500">${f.enrolment_no}</td>
                <td class="py-3 px-4">${f.academic_year} (${f.fee_type})</td>
                <td class="py-3 px-4 font-semibold text-slate-800">₹${parseFloat(f.amount_due).toLocaleString('en-IN')}</td>
                <td class="py-3 px-4 text-emerald-600 font-semibold">₹${parseFloat(f.amount_paid || 0).toLocaleString('en-IN')}</td>
                <td class="py-3 px-4 text-rose-600 font-bold">₹${parseFloat(f.balance || 0).toLocaleString('en-IN')}</td>
                <td class="py-3 px-4">
                    <span class="px-2 py-0.5 rounded-full text-2xs font-bold ${badgeColor}">${f.fee_status}</span>
                </td>
            </tr>
        `;
    }).join('');
    lucide.createIcons();
}

// -------------------------------------------------------------
// STAFF ROSTER
// -------------------------------------------------------------
function renderStaff() {
    const grid = document.getElementById('staff-grid');
    if (!grid) return;

    grid.innerHTML = state.staff.map(st => {
        return `
            <div class="bg-white border border-slate-200 rounded-2xl p-4 shadow-sm flex items-center gap-3">
                <div class="w-12 h-12 rounded-xl bg-gradient-to-tr from-slate-800 to-indigo-900 text-white font-bold flex items-center justify-center text-sm shadow">
                    ${st.full_name.charAt(0)}
                </div>
                <div class="flex-1 min-w-0">
                    <h4 class="font-bold text-slate-900 text-sm truncate">${st.full_name}</h4>
                    <span class="inline-block px-2 py-0.5 rounded bg-blue-50 text-blue-700 font-bold text-2xs mt-0.5">${st.designation}</span>
                    <div class="text-2xs text-slate-500 mt-1 truncate">📞 ${st.phone} • ✉️ ${st.email}</div>
                </div>
            </div>
        `;
    }).join('');
    lucide.createIcons();
}

// -------------------------------------------------------------
// MODALS & OVERRIDES
// -------------------------------------------------------------
function openWardenOverrideModal() {
    populateOverrideDropdowns();
    document.getElementById('modal-warden-override').classList.remove('hidden');
    lucide.createIcons();
}

function openSwapRequestModal() {
    populateSwapDropdowns();
    document.getElementById('modal-swap-request').classList.remove('hidden');
    lucide.createIcons();
}

function openPaymentModal() {
    populateFeeDropdown();
    document.getElementById('modal-record-payment').classList.remove('hidden');
    lucide.createIcons();
}

function closeModal(modalId) {
    document.getElementById(modalId).classList.add('hidden');
}

function populateDropdowns() {
    const studentSelect = document.getElementById('apply-student-id');
    const vacateSelect = document.getElementById('vacate-student-select');

    if (studentSelect) {
        studentSelect.innerHTML = state.students.map(s => `
            <option value="${s.student_id}">${s.full_name} (${s.enrolment_no} - ${s.branch})</option>
        `).join('');
    }

    if (vacateSelect) {
        const activeAllocatedStudents = state.students.filter(s =>
            state.allocations.some(a => a.student_id === s.student_id && a.allocation_status === 'ACTIVE')
        );
        vacateSelect.innerHTML = activeAllocatedStudents.map(s => `
            <option value="${s.student_id}">${s.full_name} (${s.enrolment_no})</option>
        `).join('');
    }
}

function populateOverrideDropdowns() {
    const studentSelect = document.getElementById('override-student');
    const roomSelect = document.getElementById('override-room');

    if (studentSelect) {
        studentSelect.innerHTML = state.students.map(s => `
            <option value="${s.student_id}">${s.full_name} (${s.enrolment_no})</option>
        `).join('');
    }

    if (roomSelect) {
        roomSelect.innerHTML = state.rooms.map(r => `
            <option value="${r.room_id}">Room ${r.room_number} (Floor ${r.floor_number} - Cap: ${r.capacity})</option>
        `).join('');
    }
}

function populateSwapDropdowns() {
    const reqSelect = document.getElementById('swap-requester-select');
    const targetSelect = document.getElementById('swap-target-select');

    const allocatedStudents = state.students.filter(s =>
        state.allocations.some(a => a.student_id === s.student_id && a.allocation_status === 'ACTIVE')
    );

    const options = allocatedStudents.map(s => {
        const alloc = state.allocations.find(a => a.student_id === s.student_id && a.allocation_status === 'ACTIVE');
        const room = state.rooms.find(r => r.room_id === alloc.room_id);
        return `<option value="${s.student_id}">${s.full_name} (Room ${room ? room.room_number : 'N/A'})</option>`;
    }).join('');

    if (reqSelect) reqSelect.innerHTML = options;
    if (targetSelect) targetSelect.innerHTML = options;
}

function populateFeeDropdown() {
    const feeSelect = document.getElementById('pay-fee-select');
    if (feeSelect) {
        feeSelect.innerHTML = state.fees.map(f => `
            <option value="${f.fee_id}">${f.full_name} - ${f.fee_type} (Due: ₹${f.balance})</option>
        `).join('');
    }
}

async function executeWardenOverride() {
    const studentId = document.getElementById('override-student').value;
    const roomId = document.getElementById('override-room').value;
    const reason = document.getElementById('override-reason').value;

    try {
        const res = await fetch(`${API_BASE}/api/allotments/override`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                student_id: studentId,
                target_room_id: roomId,
                reason: reason
            })
        });
        const data = await res.json();
        if (data.success) {
            showNotification(data.message, 'success');
            closeModal('modal-warden-override');
            await Promise.all([fetchAllocations(), fetchRooms(), fetchAllotmentApplications()]);
            renderAllocationFeed();
            renderRoomsGrid();
            renderDashboard();
        }
    } catch (err) {
        showNotification('Override error: ' + err.message, 'error');
    }
}

async function submitSwapRequest() {
    const reqId = document.getElementById('swap-requester-select').value;
    const targetId = document.getElementById('swap-target-select').value;
    const reason = document.getElementById('swap-reason').value;

    if (reqId === targetId) {
        showNotification('Cannot swap with the same student!', 'error');
        return;
    }

    try {
        const res = await fetch(`${API_BASE}/api/allotments/swap`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                requester_student_id: reqId,
                target_student_id: targetId,
                reason: reason
            })
        });
        const data = await res.json();
        if (data.success) {
            showNotification(data.message, 'success');
            closeModal('modal-swap-request');
            await fetchSwaps();
            renderSwapsTable();
            selectWorkflowStep(5);
        }
    } catch (err) {
        showNotification('Swap request error: ' + err.message, 'error');
    }
}

async function submitPayment() {
    const feeId = document.getElementById('pay-fee-select').value;
    const amount = document.getElementById('pay-amount').value;
    const method = document.getElementById('pay-method').value;

    try {
        const res = await fetch(`${API_BASE}/api/payments`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                fee_id: feeId,
                amount_paid: amount,
                payment_date: new Date().toISOString().split('T')[0],
                payment_method: method
            })
        });
        const data = await res.json();
        if (res.ok) {
            showNotification('Payment recorded successfully!', 'success');
            closeModal('modal-record-payment');
            await fetchFees();
            renderFees();
            renderDashboard();
        }
    } catch (err) {
        showNotification('Payment submission failed: ' + err.message, 'error');
    }
}

// -------------------------------------------------------------
// Toast Notification Utility
// -------------------------------------------------------------
function showNotification(msg, type = 'info') {
    const toast = document.createElement('div');
    const bg = type === 'success' ? 'bg-emerald-600' : (type === 'error' ? 'bg-rose-600' : 'bg-slate-900');
    toast.className = `fixed bottom-5 right-5 z-50 text-white text-xs font-semibold px-4 py-3 rounded-xl shadow-xl flex items-center gap-2 transform transition-all duration-300 ${bg}`;
    toast.innerHTML = `<span>${msg}</span>`;
    document.body.appendChild(toast);
    setTimeout(() => {
        toast.style.opacity = '0';
        setTimeout(() => toast.remove(), 300);
    }, 3500);
}
