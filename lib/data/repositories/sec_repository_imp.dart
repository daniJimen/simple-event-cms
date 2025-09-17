import 'package:sec/core/di/dependency_injection.dart';
import 'package:sec/core/models/models.dart';
import 'package:sec/data/remote_data/load_data/data_loader.dart';
import 'package:sec/domain/repositories/sec_repository.dart';

import '../remote_data/common/commons_services.dart';
import '../remote_data/update_data/data_update_info.dart';

class SecRepositoryImp extends SecRepository {
  final DataLoader dataLoader = getIt<DataLoader>();
  final DataUpdateInfo dataUpdateInfo = DataUpdateInfo(
    dataCommons: CommonsServices(),
  );

  @override
  Future<List<Event>> loadEvents() async {
    return dataLoader.loadEvents();
  }

  @override
  Future<List<Agenda>> loadEAgendas() async {
    return await dataLoader.loadAgenda();
  }

  @override
  Future<List<Speaker>> loadESpeakers() async {
    return await dataLoader.loadSpeakers();
  }

  @override
  Future<List<Sponsor>> loadSponsors() async {
    return await dataLoader.loadSponsors();
  }

  @override
  Future<void> saveEvent(Event event) async {
    await dataUpdateInfo.updateEvent(event);
  }

  @override
  Future<void> saveAgenda(Agenda agenda) async {
    await dataUpdateInfo.updateAgenda(agenda);
  }

  @override
  Future<void> saveAgendaDayById(AgendaDay agendaDay, String agendaId) async {
    Agenda? agendaFounded;
    final agendas = await loadEAgendas();
    agendaFounded = agendas.firstWhere(
      (agenda) => agenda.uid == agendaId,
      orElse: () => throw Exception("Agenda not founded"),
    );
    agendaFounded.days.add(agendaDay);
    await dataUpdateInfo.updateAgenda(agendaFounded);
  }

  @override
  Future<void> saveSpeaker(Speaker speaker) async {
    await dataUpdateInfo.updateSpeaker(speaker);
  }

  @override
  Future<void> saveSponsor(Sponsor sponsor) async {
    await dataUpdateInfo.updateSponsors(sponsor);
  }

  @override
  Future<void> removeAgenda(String agendaId) async {
    await dataUpdateInfo.removeAgenda(agendaId);
  }

  @override
  Future<void> removeAgendaDayById(String agendaDayId, String agendaId) async {
    await dataUpdateInfo.removeAgendaDayById(agendaDayId);
  }

  @override
  Future<void> removeSpeaker(String speakerId) async {
    await dataUpdateInfo.removeSpeaker(speakerId);
  }

  @override
  Future<void> removeSponsor(String sponsorId) async {
    await dataUpdateInfo.removeSponsors(sponsorId);
  }

  @override
  Future<void> removeSession(
    String agendaDayId,
    String sessionId,
    String trackId,
  ) async {
    await dataUpdateInfo.removeSession(agendaDayId, sessionId, trackId);
  }

  @override
  Future<void> saveSession(
    Session session,
    String agendaDayId,
    String agendaId,
  ) async {
    await dataUpdateInfo.saveSession(agendaDayId, session);
  }
}
