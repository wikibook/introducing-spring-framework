package mrs.domain.service.reservation;

import java.util.List;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.method.P;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import mrs.domain.model.ReservableRoom;
import mrs.domain.model.ReservableRoomId;
import mrs.domain.model.Reservation;
import mrs.domain.model.RoleName;
import mrs.domain.model.User;
import mrs.domain.repository.reservation.ReservationRepository;
import mrs.domain.repository.room.ReservableRoomRepository;

@Service
@Transactional
public class ReservationService {
    @Autowired
    ReservationRepository reservationRepository;

    @Autowired
    ReservableRoomRepository reservableRoomRepository;

    public List<Reservation> findReservations(
            ReservableRoomId reservableRoomId) {
        return reservationRepository
                .findByReservableRoom_ReservableRoomIdOrderByStartTimeAsc(
                        reservableRoomId);
    }

    public Reservation reserve(Reservation reservation) {
        ReservableRoomId reservableRoomId = reservation.getReservableRoom()
                .getReservableRoomId();

        // 비관적 락
        ReservableRoom reservable = reservableRoomRepository
                .findOneForUpdateByReservableRoomId(reservableRoomId);
        if (reservable == null) {
            throw new UnavailableReservationException(
                    "선택한 날짜와 회의실로 예약할 수 없습니다.");
        }
        // 중복 확인
        boolean overlap = reservationRepository
                .findByReservableRoom_ReservableRoomIdOrderByStartTimeAsc(
                        reservableRoomId)
                .stream().anyMatch(x -> x.overlap(reservation));
        if (overlap) {
            throw new AlreadyReservedException("입력한 시간대에 이미 예약된 건이 있습니다.");
        }
        // 예약 정보 등록
        reservationRepository.save(reservation);
        return reservation;
    }

    public void cancel(Integer reservationId, User requestUser) {
        Reservation reservation = reservationRepository.findOne(reservationId);
        if (RoleName.ADMIN != requestUser.getRoleName()
                && !Objects.equals(reservation.getUser().getUserId(),
                        requestUser.getUserId())) {
            throw new AccessDeniedException("예약을 취소할 수 없습니다.");
        }
        reservationRepository.delete(reservation);
    }

    @PreAuthorize("hasRole('ADMIN')"
            + " or #reservation.user.userId == principal.user.userId")
    public void cancel(@P("reservation") Reservation reservation) {
        reservationRepository.delete(reservation);
    }

    public Reservation findOne(Integer reservationId) {
        return reservationRepository.findOne(reservationId);
    }

}